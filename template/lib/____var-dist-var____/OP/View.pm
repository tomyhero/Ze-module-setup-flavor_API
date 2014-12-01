package <+ dist +>::OP::View;
use Ze::Class;
extends 'Ze::WAF::View';
use <+ dist +>X::Home;
use Ze::View;

sub _build_engine {
    my $self = shift;
    my $path = [
        <+ dist +>X::Home->get()->subdir('view-op'),
        <+ dist +>X::Home->get()->subdir('view-include/op')
    ];

    return Ze::View->new(
        engines => [
            {
                engine => 'Ze::View::Xslate',
                config => {
                    path   => $path,
                    module => [
                        'Text::Xslate::Bridge::Star',
                        '<+ dist +>::OP::View::Util'
                    ],
                    macro => ['macro.inc'],
                    function => {
                    },
                }
            },
            { engine => 'Ze::View::JSON', config => {} }
        ]
    );

}

EOC;
