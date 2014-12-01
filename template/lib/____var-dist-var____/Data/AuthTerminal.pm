package <+ dist +>::Data::AuthTerminal;
use strict;
use warnings;
use base qw(<+ dist +>::Data::Base);
use <+ dist +>::ObjectDriver::DBI;
use <+ dist +>X::Util;
use <+ dist +>::Data::AuthAccessToken;
use <+ dist +>::Data::Member;

__PACKAGE__->install_properties({
        columns => [qw(member_id terminal_code terminal_type terminal_info updated_at created_at)],
        datasource => 'auth_terminal',
        primary_key => ['terminal_code'],
        driver => <+ dist +>::ObjectDriver::DBI->driver,
    });

__PACKAGE__->has_a({ 
        class => '<+ dist +>::Data::Member', 
        column => 'member_id' ,
    });

sub default_values {
    return +{
        terminal_code => <+ dist +>X::Util::generate_terminal_code(),
    };
}


sub reset_access_token {
    my $self = shift;
    my $access_token = <+ dist +>X::Util::generate_access_token();
    if( my $auth_access_token_obj = <+ dist +>::Data::AuthAccessToken->single({member_id => $self->member_id}) ){
        $auth_access_token_obj->access_token( $access_token);
        $auth_access_token_obj->save();
    }
    else {
        my $obj = <+ dist +>::Data::AuthAccessToken->new();
        $obj->member_id( $self->member_id );
        $obj->access_token( $access_token );
        $obj->save();
    }
    return $access_token;
}

1;
