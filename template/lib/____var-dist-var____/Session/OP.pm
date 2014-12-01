package <+ dist +>::Session::OP;
use strict;
use warnings;
use HTTP::Session;
use HTTP::Session::State::Cookie;
use <+ dist +>::Cache::Session::OP;
use <+ dist +>X::Config;



BEGIN {
    no warnings;
    use HTTP::Session::Store::Memcached;
    *HTTP::Session::Store::Memcached::new = sub {
        my $class = shift;
        my %args = ref($_[0]) ? %{$_[0]} : @_;
        # check required parameters
        for (qw/memd/) {
            Carp::croak "missing parameter $_" unless $args{$_};
        }

    # XXX : skiped..
    #
    #    unless (ref $args{memd} && index(ref($args{memd}), 'Memcached') >= 0) {
    #        Carp::croak "memd requires instance of Cache::Memcached::Fast or Cache::Memcached";
    #    }

        bless {%args}, $class;
    };
}


sub create {
    my $class = shift;
    my $req = shift;
    my $res = shift;
    my $cookie_config =  <+ dist +>X::Config->instance()->get('op_cookie_session');

    my $session = HTTP::Session->new(
        store => HTTP::Session::Store::Memcached->new( memd =>  <+ dist +>::Cache::Session::OP->instance ),
        state => HTTP::Session::State::Cookie->new( name => $cookie_config->{namespace} ),
        request => $req,
    );


    # http headerをセットしてる程度なのでとりあえずここでもおk
    $session->response_filter($res);
    return $session;
}

1;
