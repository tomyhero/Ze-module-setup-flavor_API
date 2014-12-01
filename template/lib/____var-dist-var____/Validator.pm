package <+ dist +>::Validator;
use warnings;
use strict;
use utf8;
use FormValidator::LazyWay;
use YAML::Syck();
use Data::Section::Simple;
use <+ dist +>::Validator::Result;

sub create_config {
    my $reader = Data::Section::Simple->new(__PACKAGE__);
    my $yaml = $reader->get_data_section('validate.yaml');
    my $data = YAML::Syck::Load( $yaml);
    return $data;
}

sub instance {
    my $class = shift;
    no strict 'refs';
    my $instance = \${ "$class\::_instance" };
    defined $$instance ? $$instance : ($$instance = $class->_new);
}

sub _new {
    my $class = shift;
    my $self = bless {}, $class;
    return $self->create_validator();
}

sub create_validator {
    my $self = shift;
    my $config = $self->create_config();
    FormValidator::LazyWay->new( config => $config ,result_class => '<+ dist +>::Validator::Result' );
}

1;

__DATA__


@@ validate.yaml
---
lang: ja
filters:
  - <+ dist +>=+<+ dist +>::Validator::Filter
rules:
  - Number
  - String
  - Net
  - Email
  - DateTime
  - <+ dist +>=+<+ dist +>::Validator::Rule
setting:
  regex_map :
    '_id$':
      rule:
        - Number#uint
    '^on_':
      rule:
        - <+ dist +>#range:
              max : 1
              min : 0
  strict:
    timezone:
      rule:
        - <+ dist +>#timezone
    language: 
      rule:
        - <+ dist +>#language
    member_name: 
      filter:
        - <+ dist +>#trim_space
      rule:
        - String#length:
            max : 55
            min : 1
    terminal_type: 
      rule:
        - <+ dist +>#terminal_type
    terminal_info:
      rule:
        - String#length:
            max : 255
            min : 1
    access_token:
      rule:
        - String#length:
            max : 255
            min : 1
    op_name: 
      rule:
        - String#length:
            max : 100
            min : 1
    password:
      rule:
        - String#length:
            max : 55
            min : 4
    confirm_password:
      rule:
        - String#length:
            max : 55
            min : 4
    email:
      rule:
        - Email#email_loose
    p:
      rule:
        - Number#uint
    op_access_key:
      rule:
        - <+ dist +>#op_access_key
    op_timezone:
      rule:
        - <+ dist +>#op_timezone
    op_language:
      rule:
        - <+ dist +>#op_language
    operation_memo:
      rule:
        - String#length:
            max : 1000
            min : 1
    sort:
      rule:
        - <+ dist +>#order_by
    direction:
      rule:
        - <+ dist +>#order_direction
    operation_type:
      rule:
        - <+ dist +>#operation_type
