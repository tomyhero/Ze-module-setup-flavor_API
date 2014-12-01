package <+ dist +>::Authorizer::Operator;
use Ze::Class;
extends '<+ dist +>::Authorizer::Base';
use <+ dist +>::Session::OP;
use <+ dist +>::Model::Operator;

sub logout {
    my $self = shift;

}

sub authorize {
    my $self = shift;
    my $session = <+ dist +>::Session::OP->create($self->c->req,$self->c->res);

    if( my $operator_id = $session->get('operator_id') ){
        my $obj = <+ dist +>::Model::Operator->new->lookup($operator_id) or return;
        return unless $obj->on_active;
        return $obj;
    }
    return;
}

EOC;
