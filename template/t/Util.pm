use strict;
use warnings;
use utf8;
use lib 't/lib';

package t::Util;
use strict;
use parent qw/Exporter/;
use Ze::WAF::Request;
use <+ dist +>::Session::OP;
use Plack::Test;
use Plack::Util;
use <+ dist +>X::Home;
use Test::More();
use <+ dist +>::ObjectDriver::DBI;
use HTTP::Request::Common;
use Test::TCP qw(empty_port);
use Test::More;
use Proc::Guard;
use <+ dist +>X::Config;
use <+ dist +>X::Home;
use HTTP::Request;
use HTTP::Response;
use HTTP::Message::PSGI;
use Try::Tiny;

our @EXPORT = qw(
test_api
test_op
login_terminal
login_op
create_operator_obj
cleanup_database
create_member_obj
model_throws_ok
api_res_ok
columns_ok
aliases_ok
GET HEAD PUT POST
);

{
    package t::Proc::Guard;
    use parent qw(Proc::Guard);
    sub stop {
        my $self = shift;
        local $?;
        $self->SUPER::stop(@_);
    }
}

our $CACHE_MEMCACHED;

BEGIN {
    die 'Do not use this script on production' if $ENV{<+ dist | upper +>_ENV} && $ENV{<+ dist | upper +>_ENV} eq 'production';  

    # Home hack
    *<+ dist +>X::Home::_new_instance = sub {
        my $class = shift;
        die 'You can not use this module directory' if $class eq 'App::Home';
        my $self  = bless { }, $class;
        $self->_home()->subdir('/t/root')
    };


    my $config;
    {
      local $ENV{<+ dist | upper +>_ENV} = '';
      $config = <+ dist +>X::Config->instance();
    }

    # up memcached for caches
    my $memcached_port = empty_port();
    $config->{cache} = {
        servers => ['127.0.0.1:' . $memcached_port  ],
    };
    $config->{cache_session} = {
        servers => ['127.0.0.1:' . $memcached_port  ],
    };
    $config->{cache_session_op} = {
        servers => ['127.0.0.1:' . $memcached_port  ],
    };


    $CACHE_MEMCACHED = t::Proc::Guard->new(
        command => ['/usr/bin/env','memcached', '-p', $memcached_port]
    );


    # database接続先の上書き
    my $database_config = $config->get('database');
    $database_config->{master}{dsn} =  "dbi:mysql:<+ dist | lower +>_test_" . $ENV{<+ dist | upper +>_ENV};
    for(@{$database_config->{slaves}}){
        $_->{dsn} =  "dbi:mysql:<+ dist | lower +>_test_" . $ENV{<+ dist | upper +>_ENV};
    } 



}

sub test_api {
    my $cb = shift;
    test_psgi(
        app => Plack::Util::load_psgi( <+ dist +>X::Home->get->file('psgi/api.psgi') ),
        client => $cb,
    );
}
sub test_op {
    my $cb = shift;
    test_psgi(
        app => Plack::Util::load_psgi( <+ dist +>X::Home->get->file('psgi/op.psgi') ),
        client => $cb,
    );
}

sub create_operator_obj {
    return <+ dist +>::Model::Operator->new->create_admin_operator({
            email => 'example@example.com',
            op_name => 'Mr.Foo',
            password => 'secret',
        });
  }

sub login_op {
    my $operator_obj = shift || create_operator_obj();

    my $env = HTTP::Request->new(GET => "http://localhost/")->to_psgi;
    my $req  = Ze::WAF::Request->new($env);
    my $res  = $req->new_response;
    my $session = <+ dist +>::Session::OP->create($req,$res );
    
    $session->set('operator_id',$operator_obj->id); 
    $session->finalize();
    $ENV{HTTP_COOKIE} = $res->headers->header('SET-COOKIE');
    return $operator_obj;
}

sub cleanup_database {
    Test::More::note("TRUNCATING DATABASE");
    my $conf = <+ dist +>X::Config->instance->get('database')->{'master'};
    my @driver = ($conf->{dsn},$conf->{username},$conf->{password});
    require DBI;
    $driver[0] =~ /test/ or die "This is not in a test mode.";
    my $dbh = DBI->connect(@driver , {RaiseError => 1}) or die;

    my $tables = _get_tables($dbh);
    for my $table (@$tables) {
        $dbh->do(qq{DELETE FROM } . $table);
    }
    $dbh->disconnect;
}

sub _get_tables {
    my $dbh = shift;
    my $data = $dbh->selectall_arrayref('show tables');
    my @tables = ();
    for(@$data){
        next if $_->[0] =~ /_view$/;
        push @tables,$_->[0];
    }

    return \@tables;
}

sub create_member_obj {
    my %args = @_;
    require <+ dist +>::Model::Member;
    $args{member_name} ||= '"<xmp>テスト';
    $args{language} ||= 'ja_JP';
    $args{timezone} ||= 'Asia/Tokyo';
    my $member_obj = <+ dist +>::Model::Member->new()->create( \%args );
    return $member_obj;
}

sub model_throws_ok  {
    my ( $coderef, $error_keys, $description ) = @_;

    try {
      $coderef->();
      Test::More::fail('no error');
    }
    catch {
      my $error = $_;
      Test::More::isa_ok($error,'<+ dist +>::Validator::Error');
      Test::More::is_deeply([sort(@{$error->error_keys})],$error_keys,$description);
    };
}

sub login_terminal {
  require <+ dist +>::Model::AuthTerminal;
  my $model = <+ dist +>::Model::AuthTerminal->new();
  my $obj = $model->register({member_name => "hello",language=>'ja_JP',timezone=>'Asia/Tokyo',terminal_type =>1 , terminal_info => "hoge" });
  my $access_token = $model->login($obj->terminal_code);
  return $access_token;
}

sub api_res_ok {
  my $res = shift;    
  Test::More::is($res->code,200,"HTTP Response OK");
  eval { 
    my $content = <+ dist +>X::Util::from_json($res->content);
    is($content->{error},0,"JSON Response OK");
  };
  if($@){
    Test::More::fail($res->content);
  }
}
sub columns_ok {
    my $pkg =  shift or die 'please set data class name';

    my $dbh = <+ dist +>::ObjectDriver::DBI->driver->rw_handle;

    my %columns = map {$_ => 1 } @{$pkg->column_names};

    my $database_name = get_database_name($dbh);
    my $table_name = $pkg->datasource();


    my $sql = "select COLUMN_NAME from information_schema.columns c where c.table_schema = ? and c.table_name = ?";


    my $data = $dbh->selectall_arrayref($sql,{},$database_name,$table_name);

    my $mysql_columns = {};
    for(@$data){
        $mysql_columns->{$_->[0]} = 1; 
    }

    Test::More::is_deeply(\%columns,$mysql_columns,sprintf("%s's columns does not much with database and source code",$table_name));

}

sub get_database_name {
    my $dbh = shift;
    return $dbh->private_data->{database};
}

sub aliases_ok {
  my $obj = shift;
  my $aliases = shift;
  for(@$aliases){
    if( $obj->can($_) ){
    }
    else {
      Test::More::ok(0,$_ . ' is not alliace');
      return ;
    }
  }

  Test::More::ok(1,'aliases_ok');
}


1;
