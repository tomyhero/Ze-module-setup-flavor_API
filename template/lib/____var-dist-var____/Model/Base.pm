package <+ dist +>::Model::Base;
use Ze::Class;
extends 'Aplon';
use <+ dist +>::Validator;
use <+ dist +>::Pager;
use Try::Tiny;

with 'Aplon::Validator::FormValidator::LazyWay';
has '+error_class' => ( default => '<+ dist +>::Validator::Error' );

has 'pager' => (  is => 'rw' );



sub FL_instance {
    <+ dist +>::Validator->instance();
}

sub create_pager {
    my $self = shift;
    my $p    = shift;
    my $entries_per_page = shift || 10;
    my $pager = <+ dist +>::Pager->new();
    $pager->entries_per_page( $entries_per_page );
    $pager->current_page($p);
}


EOC;
