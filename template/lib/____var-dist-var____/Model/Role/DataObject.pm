package <+ dist +>::Model::Role::DataObject;
use Ze::Role;
use Mouse::Util;
use DBIx::TransactionManager;
use <+ dist +>::ObjectDriver::DBI;

has 'data_class' => (
    is => 'rw',
    lazy_build => 1
);

sub get_tm {
    if ( !$Ze::GLOBAL->{TM} ) {
        $Ze::GLOBAL->{TM} = DBIx::TransactionManager->new( <+ dist +>::ObjectDriver::DBI->driver->rw_handle );
    }
    return $Ze::GLOBAL->{TM};
}

sub _build_data_class {
    my $self = shift;
    my $class = ref $self;
    my @a = split('::',$class);
    my $name = $a[-1];
    my $pkg =  '<+ dist +>::Data::' . $name;
    Mouse::Util::load_class($pkg); #XXX
    return $pkg;
}

sub create {
    my $self = shift;
    my $args = shift || {};
    my $profile_name = shift;
    my $v = $self->assert_with($args);
    my $obj = $self->data_class->new( %$v ) ;
    $obj->save();
    return $obj;
}

sub lookup {
    my $self = shift;
    return $self->data_class->lookup( @_ );
}
sub lookup_or_abort {
    my $self = shift;
    my $obj = $self->lookup(@_) or $self->abort_with('not_found');
    return $obj;
}

sub search_with_pager {
    my $self  = shift;
    my $args  = shift || {};
    my $opts  = shift || {};
    my $p     = delete $args->{p} || 1;
    my $limit = $opts->{limit} || 50;
    my $v = $self->assert_with($args);

    my $pager = $self->create_pager($p);
    $pager->entries_per_page($limit);
    $pager->current_page($p);
    $opts->{pager} = $pager;
    my @objs = $self->data_class->search( $v, $opts );

    return ( $pager, \@objs );
}

sub update {
    my $self = shift;
    my $obj_or_id = shift;
    my $args = shift;
    my $opts = shift || {};

    my $profile_name = $opts->{profile_name} || 'update';

    my $obj ;
    {
        if(ref $obj_or_id ) {
            $obj = $obj_or_id;
        }
        else {
            $obj = $self->data_class->lookup( $obj_or_id ) 
                or $self->abort_with( 'obj_not_found' );
        }
    }

    my $v = $self->assert_with($args,$profile_name);
    for my $field (keys %$v){
        $obj->$field( $v->{$field} );
    }
    $obj->save();
    return $obj;
}

sub search_for_op {
    my $self = shift;
    my $args = shift;
    my $opts = shift;
    my $v =  $self->assert_with($args);

    $opts->{direction} = delete $v->{direction} if $v->{direction} ;
    $opts->{sort} = delete $v->{sort} if $v->{sort} ;

    my ($pager,$objs) = $self->data_class->search_with_pager($v,$opts);
    return ($pager,$objs);
}


1;
