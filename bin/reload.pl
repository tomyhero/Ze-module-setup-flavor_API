#!/usr/bin/env perl
#
## 俺用
system('rm -rfd ~/module-setup-flavor_api/MyApp');
system('rm -rfd ~/.module-setup/flavors/API');
system('module-setup --devel --pack > Ze/Helper/API.pm');
system('module-setup --init --flavor-class=+Ze::Helper::API API');
system('module-setup MyApp API');
