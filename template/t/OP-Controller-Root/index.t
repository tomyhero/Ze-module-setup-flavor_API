use Test::More;
use t::Util;
use <+ dist +>X::Util;

cleanup_database;

test_op(sub {
        my $cb  = shift;
        login_op();
        {
          my $res = $cb->(GET "/",{});
          is(200,$res->code)
        }
});


done_testing();
