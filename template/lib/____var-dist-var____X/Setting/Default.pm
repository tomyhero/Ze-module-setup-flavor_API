package <+ dist +>X::Setting::Default;
use strict;
use warnings;

use constant DEFAULT_LANGUAGE => 'ja_JP';
use constant SUPPORT_LANGUAGES => ['ja_JP'];

use constant DEFAULT_OP_LANGUAGE => 'en_US';
use constant DEFAULT_OP_TIMEZONE => 'Asia/Tokyo';
use constant SUPPORT_OP_LANGUAGES => ['en_US','ja_JP'];
use constant SUPPORT_OP_TIMEZONES => ['Asia/Tokyo','Asia/Taipei'];

1;
