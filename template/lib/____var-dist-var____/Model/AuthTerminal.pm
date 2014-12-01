package <+ dist +>::Model::AuthTerminal;
use Ze::Class;
use strict;
use warnings;
use <+ dist +>::Model::Member;
extends '<+ dist +>::Model::Base';
with '<+ dist +>::Model::Role::DataObject';
use Try::Tiny;

sub profiles {
    return +{
        register => { required => [qw/member_name language timezone terminal_type terminal_info/], },
        create   => { required => [qw/member_id terminal_type terminal_info/], }
    };
}


sub register {
    my $self = shift;
    my $args = shift;
    my $v    = $self->assert_with($args);

    my $tm = $self->get_tm();
    my $obj;
    try {
        my $model      = <+ dist +>::Model::Member->new;
        my $txn        = $tm->txn_scope;
        my $member_obj = $model->create($v);
        $obj = $self->create( { member_id => $member_obj->id, terminal_type => $v->{terminal_type}, terminal_info => $v->{terminal_info} } );
        $member_obj->update();
        $txn->commit;
    }
    catch {
        if ( ref $_ eq '<+ dist +>::Validator::Error' ) {
            die $_;
        }
        else {
            die $_;
        }
    };

    return $obj;
}

sub login {
    my $self          = shift;
    my $terminal_code = shift or $self->abort_with('login_fail');
    my $obj           = $self->data_class->lookup($terminal_code) or $self->abort_with('login_fail');
    $obj->member_obj->update_last_active_at( { on_save => 1 } );
    my $access_token = $obj->reset_access_token();
    return $access_token;
}

EOC;
