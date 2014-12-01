package <+ dist +>X::Config;
use parent 'Ze::Config';

sub appname {
  my $self = shift;
  my $class = ref $self;
  my $name = uc Ze::Util::app_class( $class );
  $name =~ s/X$//;
  return $name;
}
sub get_config_files {
    my $self = shift;
    my @files;
    my $home = $self->home;
    my $base = $home->file('config/config.pl');
    push @files, $base;

    if ( my $env = $ENV{ $self->appname . '_ENV' } ) {
        my $filename = sprintf 'config/config_%s.pl', $env;
        die "could not found local config file:" . $home->file($filename) unless -f $home->file($filename);
        push @files, $home->file($filename);
    }

    return \@files;
}

1;
