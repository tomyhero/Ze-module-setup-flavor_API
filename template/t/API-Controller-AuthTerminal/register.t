use Test::More;

use t::Util;

test_api(sub {
        my $cb  = shift;
        my $res = $cb->(POST "/app/auth_terminal/register",{terminal_type=>1,terminal_info=>"hoge",member_name=>'Mr.Hoge',language => 'ja_JP',timezone=>"Asia/Tokyo" });
        api_res_ok($res);
});



done_testing();
