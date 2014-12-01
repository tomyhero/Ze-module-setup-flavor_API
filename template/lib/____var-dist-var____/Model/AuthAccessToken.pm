package <+ dist +>::Model::AuthAccessToken;
use Ze::Class;
extends '<+ dist +>::Model::Base';
with '<+ dist +>::Model::Role::DataObject';

sub profiles {
    return +{
        auth => {
            required => [qw/access_token/],
        }
    }
}

sub auth {
    my $self = shift;
    my $args = shift;
    my $v = $self->assert_with($args);
    my $obj 
    = $self->data_class->lookup($v->{access_token})
        or $self->abort_with('access_fail')
    ;
  return $obj->member_obj();
  }


EOC;
