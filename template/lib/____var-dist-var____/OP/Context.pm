package <+ dist +>::OP::Context;
use Ze::Class;
use <+ dist +>::Session::OP;
extends '<+ dist +>::WAF::Context';

has 'requested_at' => ( is => 'rw');
has 'operator_obj' => ( is => 'rw');

__PACKAGE__->load_plugins(
    'Ze::WAF::Plugin::Encode',
    'Ze::WAF::Plugin::FillInForm',
    # 'Ze::WAF::Plugin::JSON'
);

sub create_session {
    my $c = shift;
  return <+ dist +>::Session::OP->create($c->req,$c->res);
}

sub abort_if_no_privilege {
    my $c = shift;
    my $access_key = shift;
    unless ( $c->operator_obj->has_privilege( $access_key ) ){
        $c->redirect('/auth/login');
        $c->abort();
    }
}

sub NOT_FOUND {
  my $c = shift;
  $c->not_found();
  $c->abort();
}

sub redirect {
    my( $c, $url, $code ) = @_;
    $code ||= 302;
    $c->res->status( $code );
    $url = ($url =~ m{^https?://}) ? $url : $c->uri_for( $url );
    $c->res->redirect( $url );
    $c->finished(1);
 }

 sub uri_for {
    my $c = shift;
    my $path = shift;
    my $config = <+ dist +>X::Config->instance();
    my $url = $config->get('url')->{op} . $path;
    return $url;
}

EOC;
