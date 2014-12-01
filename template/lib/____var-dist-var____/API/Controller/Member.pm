package <+ dist +>::API::Controller::Member;
use Ze::Class;
extends '<+ dist +>::API::Controller::Base';

sub me {
  my ($self,$c) = @_;
  $c->set_json_stash({ item => { member_id => $c->member_obj->id } });
}

EOC;
