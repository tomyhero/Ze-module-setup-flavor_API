package <+ dist +>::Validator::Rule;
use strict;
use warnings;
use DateTime::TimeZone;
use <+ dist +>X::Util;
use <+ dist +>::OP::ACL();

sub op_timezone {
    my $timezone          = shift;
    my $support_timezones = <+ dist +>X::Util::support_op_timezones;
    for my $lng (@$support_timezones) {
        if ( $lng eq $timezone ) {
            return 1;
        }
    }
    return 0;
}
sub op_language {
    my $language          = shift;
    my $support_languages = <+ dist +>X::Util::support_op_languages;
    for my $lng (@$support_languages) {
        if ( $lng eq $language ) {
            return 1;
        }
    }
    return 0;
}
sub op_access_key {
  my $key = shift;
  my $keys = <+ dist +>::OP::ACL->new->as_hashref();

  for my $k ( keys %$keys){
    return 1 if $key eq $keys->{$k} ;
  }
  return 0;
}



sub timezone {
    DateTime::TimeZone->is_valid_name(shift) ? 1 : 0;
}

sub terminal_type {
  my $type = shift;
  return $type =~ /^[1-3]$/ ? 1 : 0;
}

sub language {
    my $language          = shift;
    my $support_languages = <+ dist +>X::Util::support_languages;
    for my $lng (@$support_languages) {
        if ( $lng eq $language ) {
            return 1;
        }
    }
    return 0;
}

sub range {
  my $num  = shift;
  my $args = shift;
  return 0 unless $num =~ /^[0-9]*$/;
  return 0 if $num > $args->{max};
  return 0 if $num < $args->{min};

  return 1;
}

sub order_direction {
  my $value = shift or return 0;
  return $value =~ /^(descend|ascend)$/ ? 1 : 0;
}

sub order_by {
  my $text = shift or return 0;
  return $text =~ /^[a-z0-9_]+$/ ? 1 : 0;
}

sub operation_type {
  my $type = shift;
  return $type =~ /^[1-2]$/ ? 1 : 0;
}

1;
