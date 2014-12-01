package <+ dist +>X::Util;
use strict;
use warnings;
use Data::GUID;
use Data::GUID::URLSafe;
use Encode;
use JSON::XS;
use Digest::SHA;
use <+ dist +>X::Setting;


sub default_language {
  return <+ dist +>X::Setting->DEFAULT_LANGUAGE;
}

sub support_languages {
  return <+ dist +>X::Setting->SUPPORT_LANGUAGES;
}

sub default_op_timezone {
  return <+ dist +>X::Setting->DEFAULT_OP_TIMEZONE;
}

sub support_op_timezones {
  return <+ dist +>X::Setting->SUPPORT_OP_TIMEZONES;
}

sub default_op_language {
  return <+ dist +>X::Setting->DEFAULT_OP_LANGUAGE;
}
sub support_op_languages {
  return <+ dist +>X::Setting->SUPPORT_OP_LANGUAGES;
}


sub from_json {
  my $json = shift;
  $json = Encode::encode( 'utf8', $json );
  return JSON::XS::decode_json($json);
}

sub to_json {
  my $data = shift;
  Encode::decode( 'utf8', JSON::XS::encode_json($data) );
}

sub available_language {
    my $language = shift;
    return default_language() unless $language;

    for ( @{ support_languages() } ) {
        if ( $language eq $_ ) {
            return $language;
        }
    }
    return default_language();
}

sub generate_access_token {
    Data::GUID->new->as_base64_urlsafe;
}

sub generate_terminal_code {
    Data::GUID->new->as_base64_urlsafe;
}

sub hashed_password {
  my $password = shift;
  Digest::SHA::sha256_base64($password);
}

1;
