package <+ dist +>::WAF::Context;
use Ze::Class;
use Module::Pluggable::Object;
extends 'Ze::WAF::Context';

my $MODELS ;
BEGIN {
    $MODELS = {}; 
    my $finder = Module::Pluggable::Object->new(
        search_path => ['<+ dist +>::Model'],
        except => qr/^(<+ dist +>::Model::Base$|<+ dist +>::Model::Role::)/, 
        'require' => 1,
    );
    my @classes = $finder->plugins;
    for my $class (@classes) {
        (my $moniker = $class) =~ s/^<+ dist +>::Model:://;
        $MODELS->{$moniker} = $class;
    }
}

sub model {
    my $c =  shift;
    my $moniker= shift;
    my $args   = shift || {};
    return $MODELS->{$moniker}->new( $args );
}



EOC;
