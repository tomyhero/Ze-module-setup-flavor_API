use Test::More;
use t::Util;
use <+ dist +>::Model::Operator;
use <+ dist +>::OP::ACL;

cleanup_database();

my $model = <+ dist +>::Model::Operator->new();


subtest 'ok' => sub {
  my $obj = $model->create_admin_operator({
    email => 'example@example.com',
    op_name => 'Mr.Foo',
    password => 'secret',
  });
  $obj->save();
  isa_ok($obj,'<+ dist +>::Data::Operator');
  my $acl = <+ dist +>::OP::ACL->new();
  is( $obj->acl_token ,$acl->get_token_for_admin);
};


done_testing();
