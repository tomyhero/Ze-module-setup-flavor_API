package <+ dist +>::Data::AuthAccessToken;
use strict;
use warnings;
use base qw(<+ dist +>::Data::Base);
use <+ dist +>::ObjectDriver::DBI;
use <+ dist +>X::Util;
use <+ dist +>::Data::Member;

__PACKAGE__->install_properties({
        columns => [qw(member_id access_token updated_at created_at)],
        datasource => 'auth_access_token',
        primary_key => 'access_token',
        driver => <+ dist +>::ObjectDriver::DBI->driver,
    });

__PACKAGE__->has_a({ 
        class => '<+ dist +>::Data::Member', 
        column => 'member_id' ,
    });

sub default_values {
    return +{
        access_token => <+ dist +>X::Util::generate_access_token(),
    };
}

1;
