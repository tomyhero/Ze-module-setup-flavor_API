package <+ dist +>X::Constants;

use strict;
use warnings;
use parent qw(Exporter);

our @EXPORT_OK = ();
our %EXPORT_TAGS = (
    terminal_type      => [qw(TERMINAL_TYPE_WEB TERMINAL_TYPE_IOS TERMINAL_TYPE_ANDROID)],
    version_status     => [qw(VERSION_STATUS_OK VERSION_STATUS_REQUIRE_TO_UPDATE VERSION_STATUS_RECOMMEND_TO_UPDATE)],
    day_of_week        => [qw(MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY SATURDAY SUNDAY)],
    api_error          => [qw(API_ERROR API_ERROR_CLIENT_VERSION API_ERROR_CLIENT_MASTER API_ERROR_CLIENT_MAINTENANCE)],
    operation_type     => [qw(OPERATION_TYPE_OPERATOR_CREATE OPERATION_TYPE_OPERATOR_UPDATE)],
);

our $DATA = {};

__PACKAGE__->build_export_ok();
__PACKAGE__->make_hash_ref();

use constant MONDAY    => 1;
use constant TUESDAY   => 2;
use constant WEDNESDAY => 3;
use constant THURSDAY  => 4;
use constant FRIDAY    => 5;
use constant SATURDAY  => 6;
use constant SUNDAY    => 7;

use constant TERMINAL_TYPE_WEB     => 1;
use constant TERMINAL_TYPE_IOS     => 2;
use constant TERMINAL_TYPE_ANDROID => 3;

use constant VERSION_STATUS_OK                  => 1;
use constant VERSION_STATUS_REQUIRE_TO_UPDATE   => 2;
use constant VERSION_STATUS_RECOMMEND_TO_UPDATE => 3;

use constant API_ERROR => 1;
use constant API_ERROR_CLIENT_VERSION => 2;
use constant API_ERROR_CLIENT_MASTER  => 3;
use constant API_ERROR_CLIENT_MAINTENANCE  => 4;

use constant OPERATION_TYPE_OPERATOR_CREATE => 1;
use constant OPERATION_TYPE_OPERATOR_UPDATE => 2;



sub build_export_ok {
    for my $tag  (keys %EXPORT_TAGS ){
        for my $key (@{$EXPORT_TAGS{$tag}}){
            push @EXPORT_OK,$key;
        }
    }
}

sub make_hash_ref {
    no strict 'refs';
    for my $key(@EXPORT_OK) {
        $DATA->{$key} = $key->();
    }
    1;
}

sub as_hashref {
    return $DATA;
}

sub lookup {
  my $tag   = shift;
  my $list  = $EXPORT_TAGS{$tag};
  my $items = {};
  for (@$list) {
    $items->{ $DATA->{$_} } = $_;
  }
  return $items;
}

1;
