package <+ dist +>::OP::Controller::Member;
use Ze::Class;
extends '<+ dist +>::OP::Controller::Base';
use <+ dist +>::OP::ACL;

__PACKAGE__->add_trigger(
  BEFORE_EXECUTE => sub {
    my ( $self, $c, $action ) = @_;
    $c->abort_if_no_privilege(OP_ACL_OPERATION);
  }
);

sub index {
    my ( $self, $c ) = @_;
}


EOC;
