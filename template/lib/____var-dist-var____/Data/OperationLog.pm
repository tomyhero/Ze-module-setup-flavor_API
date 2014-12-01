package <+ dist +>::Data::OperationLog;
use strict;
use warnings;
use base qw(<+ dist +>::Data::Base);
use <+ dist +>::Data::Operator;

__PACKAGE__->install_properties({
    columns => [qw( operation_log_id operator_id operation_type criteria_code attributes_dump operation_memo updated_at created_at)],
    datasource => 'operation_log',
    primary_key => 'operation_log_id',
    driver => <+ dist +>::ObjectDriver::DBI->driver,
});

__PACKAGE__->install_plugins ([qw/AttributesDump/]);

__PACKAGE__->setup_alias({
    id => 'operation_log_id',
});

__PACKAGE__->has_a({
  class => '<+ dist +>::Data::Operator', 
  column => 'operator_id',
});

sub default_values {
    return +{
      attributes_dump => '{}',
      criteria_code => '',
      operation_memo => '',
    };
}

1;
