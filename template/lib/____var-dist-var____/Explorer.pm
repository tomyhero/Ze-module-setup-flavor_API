package <+ dist +>::Explorer;
use Ze::Class;
extends 'Ze::WAF';
use POSIX::AtFork;
use <+ dist +>X::Config;

if( <+ dist +>X::Config->instance->get('debug') ) {
    with 'Ze::WAF::Profiler';
};

sub BUILD {
    # For true random. once execute srand() per fork child.
    POSIX::AtFork->add_to_child(sub { srand() });
}
    
EOC;
