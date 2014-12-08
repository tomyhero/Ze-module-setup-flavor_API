package <+ dist +>::Model::Operator;
use Ze::Class;
use <+ dist +>X::Util;
use <+ dist +>::OP::ACL;
use <+ dist +>X::Constants qw(:operation_type);
use <+ dist +>::Data::OperationLog;
extends '<+ dist +>::Model::Base';
with '<+ dist +>::Model::Role::DataObject';

sub profiles {
  return +{
    search_for_op => {
      optional => [qw/p operator_id on_active direction sort/],
      defaults => { 
        p => 1,
        sort      => 'operator_id',
        direction => 'descend',
      }
    },
    login => {
      required => [qw/email password/],
    },
    create_from_op => {
      required => [qw/email op_name password op_timezone op_language operation_memo/],
      optional => [qw/op_access_key/],
      want_array => [qw/op_access_key/]
    },
    update_from_op => {
      required => [qw/on_active operation_memo/],
      optional => [qw/op_access_key/],
      want_array => [qw/op_access_key/]
    },
    update_password => {
      required => [qw/password confirm_password/],
    },
    update_from_op_for_operator => {
      required => [qw/op_name op_timezone op_language/],
    },
    create_admin_operator => {
      required => [qw/email op_name password/],
    },
  }
}


sub login {
  my $self = shift;
  my $args = shift;
  my $v = $self->assert_with($args);
  my $obj 
    = $self->data_class->single({ email => $v->{email}, password => <+ dist +>X::Util::hashed_password( $v->{password} ), on_active => 1 }) 
      or $self->abort_with('login_error');

  return $obj;
}


sub create_admin_operator {
    my ($self, $args) = @_;
    my $v = $self->assert_with($args);

    $self->data_class->single({ email => $v->{email} }) and $self->abort_with("already_registered");

    my $acl = <+ dist +>::OP::ACL->new();
    my $obj = $self->data_class->new(
        email => $v->{email},
        op_name => $v->{op_name},
        password => <+ dist +>X::Util::hashed_password( $v->{password} ),
        acl_token => $acl->get_token_for_admin(),
    );
    $obj->save;
    return $obj;
}

sub create_from_op {
    my ($self, $args,$operator_obj) = @_;
    $self->abort_with("you_must_be_admin") unless $operator_obj->has_privilege(OP_ACL_ADMIN);

    my $v = $self->assert_with($args);
    my $operation_memo = delete $v->{operation_memo};

    $self->data_class->single({ email => $v->{email} }) and $self->abort_with("alreaady_registered");

    my $acl = <+ dist +>::OP::ACL->new(); 
    my $acl_token = $acl->get_token_from_op_access_keys( $v->{op_access_key} );


    my $obj = $self->data_class->new(
        email => $v->{email},
        op_name => $v->{op_name},
        op_timezone => $v->{op_timezone},
        op_language => $v->{op_language},
        password => <+ dist +>X::Util::hashed_password( $v->{password} ),
        acl_token => $acl_token,
    );
    $obj->save;

    my $log_obj = <+ dist +>::Data::OperationLog->new(
      operator_id    => $operator_obj->id,
      operation_type => OPERATION_TYPE_OPERATOR_CREATE,
      operation_memo => $operation_memo,
    );

    $log_obj->criteria_code( $obj->id );
    $log_obj->save();

    return $obj;
}

sub update_from_op_for_operator {
    my ($self,$obj,$args) = @_;
    my $v = $self->assert_with($args);

    for my $key (keys %$v ){
      $obj->$key( $v->{$key} );
    }

    $obj->save();
}

sub update_from_op {
    my ($self,$obj,$args,$operator_obj) = @_;
    $self->abort_with("you_must_be_admin") unless $operator_obj->has_privilege(OP_ACL_ADMIN);
    my $v = $self->assert_with($args);

    my $acl = <+ dist +>::OP::ACL->new(); 
    my $acl_token = $acl->get_token_from_op_access_keys( $v->{op_access_key} );
    my $backup = {
      acl_token => $obj->acl_token,
      on_active => $obj->on_active,
    };

    $obj->acl_token($acl_token);
    $obj->on_active($v->{on_active});

    my $operation_memo = delete $v->{operation_memo};
    my $log_obj = <+ dist +>::Data::OperationLog->new(
      operator_id    => $operator_obj->id,
      operation_type => OPERATION_TYPE_OPERATOR_UPDATE,
      operation_memo => $operation_memo,
    );
    $log_obj->set_attributes($backup);
    $log_obj->criteria_code( $obj->id );
    $log_obj->save();

    $obj->save;
    return $obj;
}

sub update_password {
    my ($self, $obj,$args) = @_;
    my $v = $self->assert_with($args);
    unless ($v->{password} eq $v->{confirm_password}) {
      $self->abort_with('invalid_confirm_password');
    }
    $obj->password( <+ dist +>X::Util::hashed_password( $v->{password}) );
    $obj->save;
    return $obj;
}

EOC;
