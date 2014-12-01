package <+ dist +>::Authorizer::TerminalMember;
use Ze::Class;
extends '<+ dist +>::Authorizer::Base';
use <+ dist +>::Model::AuthAccessToken;
use <+ dist +>X::Config;
use Try::Tiny;

sub authorize_from_cookie {
    my $self = shift;
    my $member_obj ;
    try {
        my $access_token = $self->c->req->cookies->{'access_token'};
        $member_obj = <+ dist +>::Model::AuthAccessToken->new->auth({ access_token => $access_token });
    } catch {

    };
    return $member_obj;

}
sub authorize {
    my $self = shift;
    my $member_obj ;
    try {
        my $access_token = $self->c->req->headers->header('x-access-token');
        if( !$access_token && <+ dist +>X::Config->instance->get('debug') ){
            $access_token = $self->c->req->param('access_token') || '';
        }
        $member_obj = <+ dist +>::Model::AuthAccessToken->new->auth({ access_token => $access_token });
        $member_obj = undef unless $member_obj->on_active;
    } catch {

    };
    return $member_obj;
}

EOC;
