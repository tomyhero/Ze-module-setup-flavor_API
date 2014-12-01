use Test::More;

use_ok(<+ dist +>::Cache::Session);

my $session = <+ dist +>::Cache::Session->instance();

$session->set('a','b');
is($session->get('a'),'b');;

done_testing();
