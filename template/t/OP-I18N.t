use Test::More;

use_ok('<+ dist +>::OP::I18N');

my $i18n = <+ dist +>::OP::I18N->get_handle('en_US');


done_testing();
