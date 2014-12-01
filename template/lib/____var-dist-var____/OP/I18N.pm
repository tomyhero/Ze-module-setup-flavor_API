package <+ dist +>::OP::I18N;
use strict;
use warnings;
use base 'Locale::Maketext';

my $home;

BEGIN  {

use <+ dist +>X::Home;
    $home = <+ dist +>X::Home->get();
}


use Locale::Maketext::Lexicon {
    en_US => ['Auto'],
    ja_JP => [ Gettext => $home->file('po/op/ja_JP.po')->stringify ,'Auto'],
    _preload => 1,
    _auto    => 1, # XXX
    _style   => 'gettext',
    _decode  => 1,
};

1;
