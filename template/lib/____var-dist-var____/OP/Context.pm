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


EOC;
