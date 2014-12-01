package <+ dist +>::Validator::Filter;
use strict;
use warnings;

sub trim_space {
  my $text = shift;  
  $text =~ s/^\s+//; 
  $text =~ s/\s+$//;
  return $text;
}



1;
