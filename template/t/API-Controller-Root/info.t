use Test::More;
use t::Util;

test_api(sub {
        my $cb  = shift;
        my $res = $cb->(GET "/web/info");
        api_res_ok($res);
        });


done_testing();
