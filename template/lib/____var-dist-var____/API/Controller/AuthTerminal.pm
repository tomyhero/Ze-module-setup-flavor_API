package <+ dist +>::API::Controller::AuthTerminal;
use Ze::Class;
use <+ dist +>X::Util;
extends '<+ dist +>::API::Controller::Base';

sub register {
    my ($self,$c) = @_;
    my $args = $c->req->as_fdat;
    $args->{language} = <+ dist +>X::Util::available_language($args->{language});
    my $obj = $c->model('AuthTerminal')->register($args);
    my $member_obj = $obj->member_obj;

    $c->set_json_stash(
        { item => {
                member_id        => $obj->member_id,
                language         => $member_obj->language,
                terminal_code    => $obj->terminal_code,
            }
        }
    );
}

sub login {
    my ($self,$c) = @_;
    my $access_token = $c->model('AuthTerminal')->login($c->req->param('terminal_code'));
    $c->set_json_stash({ item => { access_token => $access_token }});
}

EOC;
