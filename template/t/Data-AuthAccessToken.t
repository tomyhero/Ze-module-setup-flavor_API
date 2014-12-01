use Test::More;
use t::Util;

cleanup_database();

use_ok('<+ dist +>::Data::AuthAccessToken');

subtest 'defaults' => sub {
  my $member_obj = create_member_obj();
  my $obj = <+ dist +>::Data::AuthAccessToken->new(
    member_id => $member_obj->id,
  );
  $obj->save();
  ok( $obj->access_token);
};

done_testing();
