package <+ dist +>::Data::Plugin::AttributesDump;

use strict;
use warnings;
use base qw(<+ dist +>::Data::Plugin::Base);
use <+ dist +>X::Util ;

__PACKAGE__->methods([qw/attributes set_attributes/]);

sub attributes {
    my $self = shift;
    return length $self->attributes_dump ? <+ dist +>X::Util::from_json($self->attributes_dump) : {};
}

sub set_attributes {
    my $self = shift;
    my $data = shift;
    $self->attributes_dump( <+ dist +>X::Util::to_json( $data ) );
}

1;
