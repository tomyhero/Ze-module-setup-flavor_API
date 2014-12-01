package <+ dist +>::Model::OperationLog;
use Ze::Class;
extends '<+ dist +>::Model::Base';
with '<+ dist +>::Model::Role::DataObject';

sub profiles {
  return +{
    search_for_op => {
      optional => [qw/p operation_log_id operator_id operation_type direction sort/],
      defaults => { 
        p => 1,
        sort      => 'operation_log_id',
        direction => 'descend',
      }
    },
  };
}

sub search_for_operation {
  my $self = shift;
  my $operation_type = shift;
  my $criteria_code = shift;

  my $cond = {
    operation_type => $operation_type
  };
  if($criteria_code){
    $cond->{criteria_code} = $criteria_code;
  }
  my ($pager,$objs) = $self->data_class->search_with_pager($cond,{ sort =>'operation_log_id',direction => 'descend'});
  return ($pager,$objs);
}

EOC;
