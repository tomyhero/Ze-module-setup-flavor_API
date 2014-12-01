use Test::More;
use t::Util;
use <+ dist +>X::Util;
use <+ dist +>::Model::AuthTerminal;

cleanup_database;

sub create_termianl_code {
  my $model = <+ dist +>::Model::AuthTerminal->new;
  my $obj = $model->register({
    terminal_type=>1,
    terminal_info=>'hoge',
    member_name=>'test',
    language=>'ja_JP',
    timezone=>'Asia/Tokyo',
  });
  return $obj->terminal_code;
}

test_api(sub {
        my $cb  = shift;

        {
          my $res = $cb->(POST "/app/auth_terminal/login",{ terminal_code => create_termianl_code() });
          api_res_ok($res);
        }

});


done_testing();
