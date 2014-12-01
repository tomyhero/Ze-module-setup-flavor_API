use Test::More;
use t::Util;
use <+ dist +>::Model::AuthAccessToken;

cleanup_database();

my $access_token = login_terminal();
my $model = <+ dist +>::Model::AuthAccessToken->new();

subtest 'ok' => sub {
  my $member_obj = $model->auth({access_token => $access_token});
  isa_ok($member_obj,'<+ dist +>::Data::Member');
};

subtest 'missing' => sub {
  model_throws_ok(sub { $model->auth({}); },['model.access_token.missing'], 'missing throw ok');
};

done_testing();
