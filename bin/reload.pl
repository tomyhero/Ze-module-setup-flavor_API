#!/usr/bin/env perl

$ENV{PERL5LIB} = '.';
#
## 俺用
system('rm -rfd ~/work/Ze-module-setup-flavor_API/MyApp');
system('rm -rfd ~/.module-setup/flavors/API');
system('module-setup --devel --pack > Ze/Helper/API.pm');
system('module-setup --init --flavor-class=+Ze::Helper::API API');
system('module-setup MyApp API');

