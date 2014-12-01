package <+ dist +>::OP::ACL;
use strict;
use warnings;
use parent qw(Exporter);
use Ze::Class;
use Data::LazyACL;

use constant OP_ACL_ADMIN => 'admin'; # special
use constant OP_ACL_REPORT => 'report';
use constant OP_ACL_OPERATION => 'operation';

our @EXPORT = ("OP_ACL_ADMIN","OP_ACL_REPORT","OP_ACL_OPERATION");

my $DATA = {};

sub make_hash_ref {
    no strict 'refs';
    for my $key(@EXPORT) {
        $DATA->{$key} = $key->();
    }
    1;
}
__PACKAGE__->make_hash_ref();

# TODO rename to master_access_keys
sub as_hashref {
    return $DATA;
}

has 'acl' => (
    is => 'rw',
  lazy_build => 1,
);

sub _build_acl {
  my $acl = Data::LazyACL->new();
  # never change order of the array.
  $acl->set_all_access_keys([OP_ACL_REPORT,OP_ACL_OPERATION]);
  return $acl;
}

sub get_token_for_admin { return -1; }

sub get_token_for_operator { 
  my $self = shift;
  return $self->acl->generate_token( [OP_ACL_REPORT,OP_ACL_OPERATION] );
}

sub generate_token {
  my $self = shift;
  my $access_keys =  shift || [];
  $self->acl->generate_token($access_keys);
}

sub get_token_from_op_access_keys {
  my $self = shift;
  my $access_keys =  shift || [];

  for(@$access_keys){
    if( $_ eq OP_ACL_ADMIN ){
      return $self->get_token_for_admin(); 
    }
  }
  return $self->acl->generate_token($access_keys);
}

sub set_token {
  my $self = shift;
  my $token = shift;
  $self->acl->set_token($token);
  return $self->acl;
}


EOC;
