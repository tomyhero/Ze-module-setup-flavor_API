package <+ dist +>::Explorer::Dispatcher;
use Ze::Class;
extends 'Ze::WAF::Dispatcher::Router';
use <+ dist +>X::Home;

sub _build_config_file {
    my $self = shift;
    $self->home->file('router/explorer.pl');
}

sub _build_home {
    my $self = shift;
    return <+ dist +>X::Home->get;
}

EOC;
