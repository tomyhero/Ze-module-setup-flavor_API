use Test::More;
use t::Util;
use lib 't/lib';
use Module::Pluggable::Object;
use <+ dist +>::ObjectDriver::DBI;

$finder = Module::Pluggable::Object->new( search_path => '<+ dist +>::Data',except => qr/^<+ dist +>::Data::Plugin::|^<+ dist +>::Data::Base/);

for($finder->plugins){
  use_ok($_);
  columns_ok($_);
}

$tables = <+ dist +>::ObjectDriver::DBI->driver->r_handle->selectcol_arrayref("show tables");
my $hashs = {};

for(@{$tables} ){
  $_ =~ s/_//g;
  $_ = lc($_);
  $hashs->{$_} = 1;
}

for($finder->plugins){
  my($name) = $_ =~ m/::([^:]+)$/;
  $name =~ s/_//g;
  $name = lc($name);
  if( $hashs->{$name} ){
    ok(1,'check ok ' . $_);
  }
  else {
    ok(0,'check ng ' . $_);
  }
}


done_testing();
