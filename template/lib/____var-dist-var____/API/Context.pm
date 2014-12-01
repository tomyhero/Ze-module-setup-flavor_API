package <+ dist +>::API::Context;
use Ze::Class;
extends '<+ dist +>::WAF::Context';
use <+ dist +>X::Util;
use <+ dist +>X::Constants;
use <+ dist +>X::Config;
use <+ dist +>::ClientDetector;

has 'member_obj' => ( is => 'rw' );
has 'requested_at' => ( is => 'rw');
has 'language' => ( is=>'rw', default => sub { <+ dist +>X::Util::default_language() } );

__PACKAGE__->load_plugins(qw(
    Ze::WAF::Plugin::AntiCSRF
    Ze::WAF::Plugin::Encode
    Ze::WAF::Plugin::FillInForm
    Ze::WAF::Plugin::JSON
    ));

sub frontend {
  my $c = shift;
  return $c->args->{frontend};
}

sub set_json_stash {
    my( $c , $args ) = @_;
    $args->{error} ||= 0;
    my $vars = {
      error => delete $args->{error},
      data => $args
    };
    $c->view_type('JSON');
    $c->stash->{VIEW_TEMPLATE_VARS} = $vars;
    $c->_set_json_callback_if();
}

sub set_json_error {
    my( $c , $v_res , $addition ) = @_;
    $c->view_type('JSON');
    my $args = { error => 1};
    if($addition){
        $args = $addition;
        $args->{error} = 1;
    }
    if($v_res && ref $v_res){
        $args->{error_keys} = $v_res->error_keys;
    }
    elsif($v_res) {
        $args->{error_keys} = [ $v_res ];
    }

    my $error_code = 'error';
    for(@{$args->{error_keys}}){
        if( $_ =~ '^model\.custom_invalid\.'){
            $error_code = $_ ;
            $error_code =~ s/^model\.custom_invalid\.//;
        }
    }

    $args->{error_code} = $error_code;
    delete $args->{error_keys} unless <+ dist +>X::Config->instance->get('debug') ;

    $c->stash->{VIEW_TEMPLATE_VARS} = $args;
    $c->_set_json_callback_if();
}


sub client_version_fail {
  my $c = shift;
  $c->view_type('JSON');
  $c->res->status( 200 );
  $c->res->body('{"error":'. <+ dist +>X::Constants::API_ERROR_CLIENT_VERSION . ',"version_status":'. <+ dist +>X::Constants::VERSION_STATUS_REQUIRE_TO_UPDATE . '}');
  $c->res->content_type( 'text/html;charset=utf-8' );
  $c->finished(1);
}

sub client_master_fail {
  my $c = shift;
  $c->view_type('JSON');
  $c->res->status( 200 );
  $c->res->body('{"error":'. <+ dist +>X::Constants::API_ERROR_CLIENT_MASTER .'}');
  $c->res->content_type( 'text/html;charset=utf-8' );
  $c->finished(1);
}

sub authorized_fail {
    my $c = shift;
    $c->view_type('JSON');
    $c->res->status( 401 );
    $c->res->body('{"error":'. <+ dist +>X::Constants::API_ERROR .',"code":401}');
    $c->res->content_type( 'text/html;charset=utf-8' );
    $c->finished(1);
}

sub forbidden_fail {
    my $c = shift;
    $c->view_type('JSON');
    $c->res->status( 403 );
    $c->res->body('{"error":'. <+ dist +>X::Constants::API_ERROR .',"code":403}');
    $c->res->content_type( 'text/html;charset=utf-8' );
    $c->finished(1);
}

sub not_found {
    my $c = shift;
    $c->view_type('JSON');
    $c->res->status( 404 );
    $c->res->body('{"error":'. <+ dist +>X::Constants::API_ERROR .'}');
    $c->res->content_type( 'text/html;charset=utf-8' );
    $c->finished(1);
}



EOC;
