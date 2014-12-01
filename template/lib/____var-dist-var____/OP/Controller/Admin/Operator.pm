package <+ dist +>::OP::Controller::Admin::Operator ;
use Ze::Class;
extends '<+ dist +>::OP::Controller::Admin::Base';
use <+ dist +>::OP::ACL;

__PACKAGE__->add_trigger(
  BEFORE_EXECUTE => sub {
    my ($self,$c,$action ) = @_;

    if (  $action =~ m/^(edit|detail)$/ ){ 
      my $obj = $c->model('Operator')->lookup($c->args->{operator_id}) or return $c->NOT_FOUND() ;
      $c->stash->{obj} = $obj;
    }

  },
);

sub index {
  my ($self,$c) = @_;
  my ($pager,$objs) = $c->model("Operator")->search_for_op($c->req->as_fdat);
  $c->stash->{pager} = $pager;
  $c->stash->{objs} = $objs;
}

sub detail {
  my ($self,$c) = @_;
  $c->template( 'admin/operator/detail');


}

sub add {
  my ($self,$c) = @_;
  my $acl = <+ dist +>::OP::ACL->new();
  $c->stash->{access_keys} = $acl->as_hashref;
  if ( $c->req->method eq 'POST' ){
    $self->do_add($c);
  }
}

sub do_add {
  my ($self,$c) = @_;
  $c->model("Operator")->create_from_op( $c->req->as_fdat,$c->operator_obj);
  return $c->redirect('/admin/operator/');
}

sub edit {
  my ($self,$c) = @_;
  $c->template( 'admin/operator/edit');
  my $obj = $c->stash->{obj};
  my $acl = <+ dist +>::OP::ACL->new();
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
  $c->model('Operator')->update_from_op($obj,$c->req->as_fdat,$c->operator_obj);
  return $c->redirect('/admin/operator/?operator_id=' . $obj->id);
}

sub operation_log {
  my ($self,$c) = @_;
  my ($pager,$objs) = $c->model("OperationLog")->search_for_op($c->req->as_fdat);
  $c->stash->{pager} = $pager;
  $c->stash->{objs} = $objs;
}

EOC;
