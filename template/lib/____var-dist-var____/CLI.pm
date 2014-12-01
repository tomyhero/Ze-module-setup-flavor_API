package <+ dist +>::CLI;
use App::Cmd::Setup -app;

sub plugin_search_path {shift}

sub _module_pluggable_options {
    return (
        except => ['<+ dist +>::CLI::Base'],
    );
};


1;
