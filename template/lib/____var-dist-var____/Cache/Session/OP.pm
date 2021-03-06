package <+ dist +>::Cache::Session::OP;
use strict;
use warnings;
use base qw(Cache::Memcached::IronPlate Class::Singleton);
use <+ dist +>X::Config();
use Cache::Memcached::Fast();

sub _new_instance {
    my $class = shift;

    my $config = <+ dist +>X::Config->instance->get('cache_session_op');

    my $cache = Cache::Memcached::Fast->new({
            utf8 => 1,
            servers => $config->{servers},
            compress_threshold => 5000,
            ketama_points => 150, 
            namespace => '<+ dist | lower +>_s_op', 
        });
    my $self = $class->SUPER::new( cache => $cache );
    return $self;
}

1;
