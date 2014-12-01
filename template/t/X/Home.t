use Test::More;

use_ok(<+ dist +>X::Home);

my $home = <+ dist +>X::Home->get();
ok(-d $home->subdir('config')->cleanup(),'home dir should have config directory');

done_testing();
