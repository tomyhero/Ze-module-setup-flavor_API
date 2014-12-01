use Test::More;
use <+ dist +>::Model::AuthTerminal;
use <+ dist +>X::Constants qw(:terminal_type);

cleanup_database();
my $model = <+ dist +>::Model::AuthTerminal->new();

subtest 'ok' => sub {
  my $obj = $model->register({
    member_name => "hello",
    language => "ja_JP",
    timezone => "Asia/Tokyo",
    terminal_type => TERMINAL_TYPE_WEB,
    terminal_info => "hoge",
  });
  ok($obj->terminal_code);
  my $member_obj = $obj->member_obj;
  isa_ok($member_obj,'<+ dist +>::Data::Member');
};

done_testing();
