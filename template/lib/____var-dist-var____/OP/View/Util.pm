package <+ dist +>::OP::View::Util;

use strict;
use warnings;
use parent 'Text::Xslate::Bridge';
use <+ dist +>X::Config;
use <+ dist +>X::Constants;
use JSON::XS;
use Encode;

__PACKAGE__->bridge(
    function => { 
      lookup_const => \&lookup_const, 
      json => \&json,
    },
);

sub lookup_const {
  my $tag = shift;
  my $items = <+ dist +>X::Constants::lookup($tag);
  my $TAG = uc($tag);
  my $i = {};
  for my $value (keys %$items){
    my $new_key = $items->{$value};
    $new_key =~ s/$TAG\_//;
    $i->{$value} = $new_key;
  }
  return $i;
}

sub json {
    my $value = shift || {};
    return Text::Xslate::Util::mark_raw( Encode::decode('utf8',JSON::XS::encode_json( $value )));
}

1;
