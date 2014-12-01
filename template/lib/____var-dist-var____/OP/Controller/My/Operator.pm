package <+ dist +>::OP::Controller::My::Operator;
use Ze::Class;
extends '<+ dist +>::OP::Controller::Base';
use <+ dist +>::OP::ACL;

sub index {
    my ( $self, $c ) = @_;

}

sub edit {
    my ( $self, $c ) = @_;
  my $acl = <+ dist +>::OP::ACL->new();
  my $obj = $c->operator_obj;
  $c->stash->{access_keys} = $acl->as_hashref;

  if( $c->req->method eq 'POST' ) {
    $self->do_edit($c,$obj);
  }

  my $fdat = $obj->as_fdat;
  $fdat->{op_access_key} = $obj->access_keys;
  $c->stash->{fdat} = $fdat;
}

sub do_edit {
  my ($self,$c,$obj) = @_;
  $c->model('Operator')->update_from_op_for_operator($obj,$c->req->as_fdat);
  return $c->redirect('/my/operator/');
}

sub edit_password {
  my ( $self, $c ) = @_;
  $c->on_fillin(0);
  my $obj = $c->operator_obj;
  if( $c->req->method eq 'POST' ) {
    $self->do_edit_password($c,$obj);
  }

}
sub do_edit_password {
  my ( $self,$c,$obj) = @_;
  $c->model('Operator')->update_password($obj,$c->req->as_fdat);
  return $c->redirect('/my/operator/');
}

EOC;
