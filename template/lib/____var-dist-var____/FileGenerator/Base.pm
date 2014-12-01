package <+ dist +>::FileGenerator::Base;
use warnings;
use strict;
use <+ dist +>::FileGenerator -command;
use parent 'Ze::FileGenerator::Base';
use Ze::View;
use <+ dist +>X::Home;

my $home = <+ dist +>X::Home->get();

__PACKAGE__->in_path( $home->subdir("view-component") );
__PACKAGE__->out_path( $home->subdir("view-include/component") );


sub create_view {

    my $path = [ $home->subdir('view-component') , $home->subdir('view-include') ];

    return Ze::View->new(
        engines => [
            { engine => 'Ze::View::Xslate' , config => { path => $path , module => ['Text::Xslate::Bridge::Star' ] } }, 
            { engine => 'Ze::View::JSON', config  => {} } 
        ]
    );

}

sub execute {
    my ($self, $opt, $args) = @_;
    $self->setup();
    $self->run( $opt , $args );
}

1;
