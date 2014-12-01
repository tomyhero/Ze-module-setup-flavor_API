use Test::More;
use t::Util;
use <+ dist +>X::Constants qw(:terminal_type);

cleanup_database();

use_ok('<+ dist +>::Data::AuthTerminal');

subtest 'defaults' => sub {
  my $member_obj = create_member_obj();
  my $obj = <+ dist +>::Data::AuthTerminal->new(
    member_id => $member_obj->id,
    terminal_type => TERMINAL_TYPE_IOS,
    terminal_info => 'Android/XXX',
  );
  $obj->save();
  ok( $obj->terminal_code);
};

subtest 'reset_access_token' => sub {
  my $member_obj = create_member_obj();
  my $obj = <+ dist +>::Data::AuthTerminal->new(
    member_id => $member_obj->id,
    terminal_type => TERMINAL_TYPE_IOS,
    terminal_info => 'Android/XXX',
  );
  $obj->save();
  my $access_token = $obj->reset_access_token();
  ok( $access_token );
  my $access_token2 = $obj->reset_access_token();
  $access_token2 = $obj->reset_access_token();
  ok( $access_token2 );
  ok( $access_token ne $access_token2 );
};


done_testing();
