use strict;
use warnings;
use FindBin::libs;
use Plack::App::URLMap;
use Plack::Util;

use <+ dist +>X::Home;

my $home = <+ dist +>X::Home->get;

my $api = Plack::Util::load_psgi( $home->file('psgi/api.psgi'));
my $explorer = Plack::Util::load_psgi( $home->file('psgi/explorer.psgi'));

my $urlmap = Plack::App::URLMap->new;
$urlmap->map("/" => $explorer); # XXX
$urlmap->map("/api" => $api);
$urlmap->map("/explorer" => $explorer);

$urlmap->to_app;
