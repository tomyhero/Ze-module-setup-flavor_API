package <+ dist +>::Explorer::Context;
use Ze::Class;
extends '<+ dist +>::WAF::Context';
with '<+ dist +>::Role::Config';

__PACKAGE__->load_plugins(qw(
    Ze::WAF::Plugin::Encode
    Ze::WAF::Plugin::FillInForm
    Ze::WAF::Plugin::JSON
    ));


EOC;
