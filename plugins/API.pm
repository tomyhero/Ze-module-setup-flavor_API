package Ze::_::Helper::API;
use strict;
use warnings;
use base 'Module::Setup::Plugin';

use Template;
my $TEMPLATE;


sub register {
    my ( $self, ) = @_;

    $TEMPLATE = Template->new({
           START_TAG => quotemeta('<+'),
          END_TAG   => quotemeta('+>'),
      });
    $self->add_trigger( template_process => \&template_process );

    $self->add_trigger( 'after_setup_template_vars' => \&after_setup_template_vars );


}

sub template_process {
    my($self, $opts) = @_;
    return unless $opts->{template};
    my $template = delete $opts->{template};;
    $TEMPLATE->process(\$template, $opts->{vars}, \my $content);
    $opts->{content} = $content;
}


sub after_setup_template_vars {
    my ( $self, $config ) = @_;

    my $name = $self->distribute->{module};

    $config->{appname} = lc $config->{module};

    $config;

}
1;

