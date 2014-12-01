package <+ dist +>::OP::Controller::Admin::OperationLog;
use Ze::Class;
extends '<+ dist +>::OP::Controller::Admin::Base';
use <+ dist +>::OP::ACL;

__PACKAGE__->add_trigger(
  BEFORE_EXECUTE => sub {
    my ($self,$c,$action ) = @_;

    if (  $action =~ m/^(detail)$/ ){ 
      my $obj = $c->model('OperationLog')->lookup($c->args->{operation_log_id}) or return $c->NOT_FOUND() ;
      $c->stash->{obj} = $obj;
    }

  },
);

sub index {
  my ($self,$c) = @_;
  my ($pager,$objs) = $c->model("OperationLog")->search_for_op($c->req->as_fdat);
  $c->stash->{pager} = $pager;
  $c->stash->{objs} = $objs;
}

sub detail {
  my ($self,$c) = @_;
  $c->template( 'admin/operation_log/detail');

}

EOC;
