package <+ dist +>::ClientDetector;
use strict;
use Ze::Class;
use <+ dist +>X::Config;
use <+ dist +>X::Constants qw(:version_status :terminal_type);

has 'application_version' => ( is=> 'rw',required => 1 );
has 'client_name' => ( is => 'rw');
has 'version' => ( is => 'rw');

sub BUILD {
    my $self = shift;
    $self->_parse_application_version($self->application_version);
}

sub _parse_application_version {
    my $self = shift;
    my $application_version = shift or die 'application_version not found';
    my ($client,$version) = split('_',$application_version);
    die 'Client Not Found' unless $client =~ /^(iOS|Android)$/;
    die 'not version' unless $version =~ /^[0-9]*$/;

    $self->client_name($client);
    $self->version($version);
}

sub is_iOS {
    my $self = shift;
    return $self->client_name eq 'iOS' ? 1 : 0;
}

sub get_version_status {
    my $self = shift;
    my $config = <+ dist +>X::Config->instance()->get('application_version')->{$self->client_name};
    return VERSION_STATUS_REQUIRE_TO_UPDATE if $self->version < $config->{min};
    return VERSION_STATUS_RECOMMEND_TO_UPDATE  if $self->version < $config->{current};
    return VERSION_STATUS_OK;
}

sub is_required_to_update {
    my $self = shift;
    my $status = $self->get_version_status();
    return $status == VERSION_STATUS_REQUIRE_TO_UPDATE ? 1 : 0;
}

sub terminal_type {
    my $self = shift;
    return TERMINAL_TYPE_IOS if $self->client_name eq 'iOS';
    return TERMINAL_TYPE_ANDROID  if $self->client_name eq 'Android';
}

EOC;
