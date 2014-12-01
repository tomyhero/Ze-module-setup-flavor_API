package <+ dist +>::WAF::Controller;
use Ze::Class;
use Try::Tiny;
use Class::Trigger;
extends "Ze::WAF::Controller";

sub EXECUTE {
    my( $self, $c, $action ) = @_;

    try {
        $self->call_trigger('BEFORE_EXECUTE',$c,$action);
        $self->$action( $c );
    }
    catch {
        if( ref $_ && ref $_ eq '<+ dist +>::Validator::Error') {

            if($c->view_type && $c->view_type eq 'JSON') {
                $c->set_json_error($_);
            }
            else {
                $c->stash->{fdat} = $_->valid;
                $c->stash->{error_obj} = $_;
            }
        }
        elsif ( ref $_ ) {
            die Dumper $_;
        }
        else {
            die $_;
        }
    };

    $self->call_trigger('AFTER_EXECUTE',$c,$action);

    return 1;
}


EOC;
