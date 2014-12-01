package <+ dist +>::OP::Controller::Auth ;
use Ze::Class;
extends '<+ dist +>::OP::Controller::Base';

sub login {
    my ( $self, $c ) = @_;
    if($c->req->method eq 'POST'){
        $self->do_login($c);
    }
}

sub logout {
    my ( $self, $c ) = @_;
  my $session = $c->create_session;
  $session->set("operator_id" => undef );
  $session->finalize;
  $c->redirect("/");
}

sub do_login {
  my $self = shift;
  my $c = shift;
  my $obj = $c->model('Operator')->login($c->req->as_fdat);
  my $session = $c->create_session;
  $session->set("operator_id" => $obj->id);
  $session->finalize;
  $c->redirect("/");
}

EOC;
