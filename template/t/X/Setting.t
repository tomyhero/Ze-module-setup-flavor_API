use Test::More;

use_ok('<+ dist +>X::Setting');

ok(<+ dist +>X::Setting->DEFAULT_LANGUAGE());

done_testing();
