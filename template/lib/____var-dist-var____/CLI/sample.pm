package <+ dist +>::CLI::sample;
use Ze::Class;
extends '<+ dist +>::CLI::Base';

sub execute {
    my ($self, $opt, $args) = @_;
    if( scalar @$args ) {
        print $args->[0] . "\n";
    }
    else {
        print "Hi!\n";
    }
}


EOC;
