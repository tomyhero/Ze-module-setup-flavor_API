package <+ dist +>::API::Controller::Root;
use Ze::Class;
extends '<+ dist +>::WAF::Controller';
with 'Ze::WAF::Controller::Role::JSON';

sub info {
  my ($self,$c)  = @_;
  my $sheet = shift;
  $c->set_json_stash({});
}



1;
