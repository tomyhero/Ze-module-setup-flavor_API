use Test::More;
use strict;
use warnings;
use <+ dist +>::Model::Member;

my $model = <+ dist +>::Model::Member->new();

subtest 'ok' => sub {
  my $obj = $model->create({
    member_name => "Mr.Boo",
    language => "ja_JP",
    timezone => "Asia/Tokyo",
  });
  isa_ok($obj,"<+ dist +>::Data::Member");
};

subtest 'missing' => sub {
  model_throws_ok ( sub { $model->create({}) },['model.language.missing','model.member_name.missing','model.timezone.missing']);
};


done_testing();
