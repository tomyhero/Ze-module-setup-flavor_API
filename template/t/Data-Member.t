use Test::More;
use t::Util;
use_ok('<+ dist +>::Data::Member');

cleanup_database();


subtest 'alias' => sub {
  my $obj = <+ dist +>::Data::Member->new(
    member_name => "Mr.Foo",
    language  => 'ja_JP',
    timezone => 'Asia/Tokyo' 
  );
  $obj->save();
  is($obj->member_id,$obj->id);
};



done_testing();
