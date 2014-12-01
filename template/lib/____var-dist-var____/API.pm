package <+ dist +>::API;
use Ze::Class;
extends 'Ze::WAF';
use POSIX::AtFork;

sub BUILD {
    # For true random. once execute srand() per fork child.
    POSIX::AtFork->add_to_child(sub { srand() });
}
    
EOC;
