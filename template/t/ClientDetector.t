use Test::More;
use strict;
use <+ dist +>::ClientDetector;
use <+ dist +>X::Constants qw(:terminal_type);

subtest 'ios ok' => sub { 
    my $obj = <+ dist +>::ClientDetector->new({ application_version => 'iOS_1' });
    is($obj->version,1);
    is($obj->client_name,'iOS');
};

subtest 'get_version_status' => sub {
    my $obj = <+ dist +>::ClientDetector->new({ application_version => 'iOS_1' });
    ok($obj->get_version_status());
};

subtest 'terminal_type' => sub {
    {
        my $obj = <+ dist +>::ClientDetector->new({ application_version => 'iOS_1' });
        is($obj->terminal_type(), TERMINAL_TYPE_IOS);
    }
    {
        my $obj = <+ dist +>::ClientDetector->new({ application_version => 'Android_1' });
        is($obj->terminal_type(), TERMINAL_TYPE_ANDROID);
    }
};

done_testing();
