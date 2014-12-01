package <+ dist +>X::DateTime;
use strict;
use warnings;
use base qw( DateTime );
use DateTime::TimeZone;
use DateTime::Format::Strptime;
use DateTime::Format::MySQL;
use <+ dist +>X::Constants qw(:day_of_week);


*DateTime::fmt_datetime = sub {
  my $self = shift;
  $self->strftime('%Y-%m-%d %H:%M:%S');
};


our $DEFAULT_TIMEZONE = DateTime::TimeZone->new( name => 'UTC' );

sub new {
    my ( $class, %opts ) = @_;
    $opts{time_zone} ||= $DEFAULT_TIMEZONE;
    return $class->SUPER::new(%opts);
}

sub now {
    my ( $class, %opts ) = @_;
    $opts{time_zone} ||= $DEFAULT_TIMEZONE;
    return $class->SUPER::now(%opts);
}

sub from_epoch {
    my $class = shift;
    my %p = @_ == 1 ? ( epoch => $_[0] ) : @_;
    $p{time_zone} ||= $DEFAULT_TIMEZONE;
    return $class->SUPER::from_epoch(%p);
}

sub parse_mysql_datetime {
    my $class    = shift;
    my $datetime = shift;
    return DateTime::Format::MySQL->parse_datetime($datetime);
}

sub parse {
    my ( $class, $format, $date ) = @_;
    $format ||= 'MySQL';

    my $module;
    if ( ref $format ) {
        $module = $format;
    }
    else {
        $module = "DateTime::Format::$format";
        eval "require $module";
        die $@ if $@;
    }

    my $dt = $module->parse_datetime($date) or return;

    $dt->set_time_zone( $DEFAULT_TIMEZONE || 'local' )
    unless $dt->time_zone->is_floating;

    return bless $dt, $class;
}

sub strptime {
    my ( $class, $pattern, $date ) = @_;
    my $format = DateTime::Format::Strptime->new(
        pattern   => $pattern,
        time_zone => $DEFAULT_TIMEZONE || 'local',
    );
    $class->parse( $format, $date );
}

sub set_time_zone {
    my $self = shift;
    eval { $self->SUPER::set_time_zone(@_) };
    if ($@) {
        $self->SUPER::set_time_zone('UTC');
    }
    return $self;
}

sub sql_now {
    my ( $class, %options ) = @_;
    my $self = $class->now(%options);
    $self->strftime('%Y-%m-%d %H:%M:%S');
}

sub yesterday {
    my $class = shift;
    my $now   = $class->now();
    return $now->subtract( days => 1 );
}

sub first_day_of_week {
    my ( $class, $year, $week ) = @_;
    return $class->new( year => $year, month => 1, day => 4 )->add( weeks => ( $week - 1 ) )->truncate( to => 'week' );
}

sub day_of_week {
    my $self        = shift;
    my $day_of_week = $self->SUPER::day_of_week;
    if ( $_[0] && $_[0] =~ /^\d$/ ) {
        my $start_day = $_[0];
        $day_of_week = ( $day_of_week >= $start_day ) ? $day_of_week - ( $start_day - 1 ) : $day_of_week + ( 8 - $start_day );
    }
    return $day_of_week;
}

sub offset_to_nextweek {
    my ( $self, $start_day ) = @_;
    my $day = $self->day_of_week($start_day);
    return 4 - ( ( $day + 8 ) % 8 );
}

sub last_day_of_month {
    my $self = shift;
    my $dt = $self->clone;
    return $dt->set_day(1)->add(months => 1)->subtract(days => 1)->day;
}

1;
