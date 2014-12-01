package <+ dist +>::CLI::Base;
use Ze::Class;
use <+ dist +>::CLI -command;
with '<+ dist +>::Role::Config';
use Try::Tiny;
use Data::Dumper;


sub execute {
    my ($self, $opt, $args) = @_;

    try {
        $self->run($opt,$args);
    } 
    catch {
        warn Dumper $_;
    };
}

EOC;
