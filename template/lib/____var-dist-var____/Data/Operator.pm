package <+ dist +>::Data::Operator;
use strict;
use warnings;
use base qw(<+ dist +>::Data::Base);
use <+ dist +>::ObjectDriver::DBI;
use <+ dist +>::OP::ACL;
use <+ dist +>X::Util;

__PACKAGE__->install_properties(
    {
        columns => [
            qw(operator_id op_name email password op_timezone op_language acl_token on_active updated_at created_at)
        ],
        datasource  => 'operator',
        primary_key => 'operator_id',
        driver      => <+ dist +>::ObjectDriver::DBI->driver,
    }
);

__PACKAGE__->setup_alias({ id => 'operator_id'  });

sub default_values {
   my $acl = <+ dist +>::OP::ACL->new();
  +{
    op_timezone => <+ dist +>X::Util::default_op_timezone(),
    op_language => <+ dist +>X::Util::default_op_language(),
    acl_token => $acl->get_token_for_operator(),
    on_active => 1,
  };
}

sub access_keys {
  my $self = shift;
  my $keys = $self->acl_obj->retrieve_access_keys_for($self->acl_token);
  @$keys = sort @$keys;
  return $keys;
}

sub acl_obj {
  my $self = shift;
  my $acl = <+ dist +>::OP::ACL->new();
  return $acl->set_token( $self->acl_token );
}
sub has_privilege {
  my $self = shift;
  my $access_key = shift;
  $self->acl_obj->has_privilege( $access_key );
}

1;
