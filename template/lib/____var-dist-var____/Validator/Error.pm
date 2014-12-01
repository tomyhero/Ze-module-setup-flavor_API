package <+ dist +>::Validator::Error;
use strict;
use warnings;
use Ze::Class;
extends 'Aplon::Error';
with 'Aplon::Error::Role::LazyWay';

use overload ( q{""} => \&as_string);

sub as_string {
    my $self = shift;
    return join "\n", '<+ dist +>::Validator::Error', @{$self->error_keys};
}


sub errors {
  my $self = shift;
  my @errors = ();
  for my $field ( keys %{$self->error_message} ) {
      my $item = $self->error_message->{$field};
      if (ref $item eq 'ARRAY' ){
        push @errors, @$item; 
      }
      else{
        push @errors, $item; 
      }
  }
  return \@errors;
}

EOC;
