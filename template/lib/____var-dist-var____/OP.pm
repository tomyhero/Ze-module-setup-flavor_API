package <+ dist +>::OP;
use Ze::Class;
extends 'Ze::WAF';
use <+ dist +>X::Config;
use POSIX::AtFork;

sub BUILD {
  # For true random. once execute srand() per fork child.
  POSIX::AtFork->add_to_child(sub { srand() });
}


EOC;
