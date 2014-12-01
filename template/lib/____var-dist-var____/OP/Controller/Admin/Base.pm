package <+ dist +>::OP::Controller::Admin::Base ;
use Ze::Class;
extends '<+ dist +>::OP::Controller::Base';
use <+ dist +>::OP::ACL;

__PACKAGE__->add_trigger(
  BEFORE_EXECUTE => sub {
    my ( $self, $c, $action ) = @_;
    $c->abort_if_no_privilege(OP_ACL_ADMIN);
  }
);

EOC;
