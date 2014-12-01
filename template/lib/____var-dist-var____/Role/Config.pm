package <+ dist +>::Role::Config;
use strict;
use Ze::Role;
use <+ dist +>X::Config;

sub config {
    return <+ dist +>X::Config->instance();
}

1;
