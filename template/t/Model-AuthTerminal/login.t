use Test::More;
use <+ dist +>::Model::AuthTerminal;
use t::Util;

cleanup_database();

my $model = <+ dist +>::Model::AuthTerminal->new();
my $obj = $model->register({ terminal_type => 1, terminal_info => "HOGE", member_name => "hello",language=>'ja_JP',timezone=>'Asia/Tokyo' });

my $last_active_at;
{
  my $member_obj = $obj->member_obj();
  $last_active_at = $member_obj->last_active_at('2000-12-12 12:12:12');
  $member_obj->save();
}

my $access_token = $model->login($obj->terminal_code);

ok($obj->member_obj()->last_active_at ne $last_active_at);

ok($access_token);
ok($model->login($obj->terminal_code) ne $access_token );

done_testing();
