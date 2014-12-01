use Test::More;
use t::Util;

cleanup_database();

use_ok('<+ dist +>::Data::Operator');

subtest 'defaults' => sub {
  my $obj = <+ dist +>::Data::Operator->new(
    op_name => 'Mr.Hoge',
    email => 'example@example.com',
    password => 'secret',
  );
  $obj->save();
  isa_ok($obj,'<+ dist +>::Data::Operator');
};

done_testing();
