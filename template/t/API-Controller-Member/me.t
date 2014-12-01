use Test::More;
use t::Util;

cleanup_database;


test_api(sub {
        my $cb  = shift;

        {
          my $res = $cb->(POST "/app/member/me",x_access_token => login_terminal() );
          api_res_ok($res);
        }

        {
          my $res = $cb->(POST "/app/member/me" );
          is($res->code,401);
        }

});


done_testing();
