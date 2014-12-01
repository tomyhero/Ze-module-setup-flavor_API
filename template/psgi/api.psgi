use strict;
use FindBin::libs;
use Plack::Builder;
use File::RotateLogs;

use <+ dist +>::API;
use <+ dist +>X::Home;
use <+ dist +>::Validator;
use <+ dist +>X::Config;
use Plack::Middleware::ServerStatus::Lite;


# TODO LOAD INTO MEMORY


# singletonize Validator
<+ dist +>::Validator->instance();    # compile

my $home = <+ dist +>X::Home->get;

my $webapp = <+ dist +>::API->new;

my $app = $webapp->to_app;

my $config = <+ dist +>X::Config->instance();
my $middlewares = $config->get('middleware') || {};

if ($middlewares) {
  $middlewares = $middlewares->{api} || [];
}

builder {
  enable 'Plack::Middleware::Static',
      path => qr{^/static/},
      root => $home->file('htdocs');

  enable_if { $_[0]->{REMOTE_ADDR} eq '127.0.0.1' } "Plack::Middleware::ReverseProxy";

  if ( $ENV{<+ dist | upper +>_ENV} eq 'production' ) {
    my $rotatelogs = File::RotateLogs->new(
      logfile      => '/var/log/<+ dist | lower +>-server/access_log.%Y%m%d%H%M',
      linkname     => '/var/log/<+ dist | lower +>-server/access_log',
      rotationtime => 3600,
      maxage       => 86400 * 7,
    );
    
    enable 'Plack::Middleware::AxsLog',
        combined      => 1,
        response_time => 1,
        logger        => sub { $rotatelogs->print(@_) };
  }

  for (@$middlewares) {
    if ( $_->{opts} ) {
      enable $_->{name}, %{ $_->{opts} };
    }
    else {
      enable $_->{name};
    }
  }

  $app;
};
