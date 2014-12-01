use Test::More;
use strict;
use warnings;
use <+ dist +>::OP::ACL;

{
  my $acl = <+ dist +>::OP::ACL->new();
  my $acl_token = $acl->get_token_for_operator();
  my $acl_obj = $acl->set_token($acl_token);

  ok( $acl_obj->has_privilege(OP_ACL_REPORT) );
  ok( $acl_obj->has_privilege(OP_ACL_OPERATION) );
  ok( !$acl_obj->has_privilege(OP_ACL_ADMIN) );
}

{
  my $acl = <+ dist +>::OP::ACL->new();
  my $acl_token = $acl->get_token_for_admin;
  my $acl_obj = $acl->set_token($acl_token);

  ok( $acl_obj->has_privilege(OP_ACL_REPORT) );
  ok( $acl_obj->has_privilege(OP_ACL_OPERATION) );
  ok( $acl_obj->has_privilege(OP_ACL_ADMIN) );


}

done_testing();
