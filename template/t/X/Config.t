use Test::More;

use_ok(<+ dist +>X::Config);

my $servers = <+ dist +>X::Config->instance->get('cache')->{servers};

is(1,scalar @$servers);

done_testing();
