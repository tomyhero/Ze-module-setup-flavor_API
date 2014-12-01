use Test::More;

use_ok('<+ dist +>::Validator::Error');


my $error = <+ dist +>::Validator::Error->new();
is("<+ dist +>::Validator::Error","$error","overload ok");


done_testing();
