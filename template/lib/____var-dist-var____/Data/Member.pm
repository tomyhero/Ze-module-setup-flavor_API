package <+ dist +>::Data::Member;
use strict;
use warnings;
use base qw(<+ dist +>::Data::Base);

__PACKAGE__->install_properties({
        columns => [qw( member_id member_name language timezone last_active_at on_active updated_at created_at)],
        datasource => 'member',
        primary_key => 'member_id',
        driver => <+ dist +>::ObjectDriver::DBI->driver,
    });

__PACKAGE__->setup_alias({
    id => 'member_id',
    name => 'member_name',
});

sub default_values {
    my $now = <+ dist +>X::DateTime->now();
    return +{
      last_active_at => $now->strftime( '%Y-%m-%d %H:%M:%S' ),
      on_active => 1,
    };
}

sub update_last_active_at {
  my $self = shift;
  my $args = shift || { on_save => 0 };
  $self->last_active_at( <+ dist +>X::DateTime->sql_now );
  $self->save() if $args->{on_save};
}
1;
