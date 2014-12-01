package <+ dist +>::API::Controller::Base;
use strict;
use Ze::Class;
extends '<+ dist +>::WAF::Controller';
with 'Ze::WAF::Controller::Role::JSON';
use <+ dist +>::Authorizer::TerminalMember;
use <+ dist +>::ClientDetector;
use <+ dist +>X::Config;
use <+ dist +>X::DateTime;
use <+ dist +>::OP::ACL;

__PACKAGE__->add_trigger(
    BEFORE_EXECUTE => sub {
        my ($self,$c,$action) = @_;

        my $now = <+ dist +>X::DateTime->now();
        $c->requested_at($now);

        if( $c->req->method ne 'POST'){
            $c->authorized_fail();
            $c->abort();
        }

        return if $c->req->path =~ /^\/(app|web)\/auth_terminal\//;
        return if $c->req->path =~ /^\/(app|web)\/master\//;

        if ($c->frontend eq 'app') {
            if(my $application_version = $c->req->headers->header('x-application-version')){
                my $client_detector = <+ dist +>::ClientDetector->new({application_version => $application_version});
                $c->client_detector($client_detector);
                if($client_detector->is_required_to_update){
                    $c->client_version_fail();
                    $c->abort();
                }
            }

            if(my $master_version = $c->req->headers->header('x-master-version')){
                my $sheet = Cream::Structure->get_basic_info_sheet();
                if( $sheet->{master_version} > $master_version ){
                    $c->client_master_fail();
                    $c->abort();
                }

            }

            my $authorizer = <+ dist +>::Authorizer::TerminalMember->new(c=>$c);

            if( my $member_obj = $authorizer->authorize() ) {
                $c->member_obj($member_obj);
                $c->language( $c->member_obj->language );
            }
            else {
                $c->authorized_fail();
                $c->abort();
            }
        }
        elsif( $c->frontend eq 'web' ){

            my $authorizer = <+ dist +>::Authorizer::TerminalMember->new(c=>$c);

            if( my $member_obj = $authorizer->authorize_from_cookie() ) {
                $c->member_obj($member_obj);
                $c->language( $c->member_obj->language );
            }
            else {
                $c->authorized_fail();
                $c->abort();
            }
        }
    });

EOC;
