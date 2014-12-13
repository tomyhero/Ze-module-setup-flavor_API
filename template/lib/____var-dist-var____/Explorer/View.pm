package <+ dist +>::Explorer::View;
use Ze::Class;
extends "Ze::WAF::View";
use Ze::View;


sub _build_engine {
    my $self = shift;
    my $path = [
        <+ dist +>X::Home->get()->subdir('view-explorer'),
        <+ dist +>X::Home->get()->subdir('view-include/explorer')
    ];
    return Ze::View->new(
        engines => [
            { 
              engine => 'Ze::View::Xslate', 
              config  => {
                path => $path
              } 
            }, 
            { 
              engine => 'Ze::View::JSON', 
            }
        ]
    );
}


EOC;
