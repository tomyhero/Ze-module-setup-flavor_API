package <+ dist +>::Model::Member;
use Ze::Class;
use strict;
use warnings;
extends '<+ dist +>::Model::Base';
with '<+ dist +>::Model::Role::DataObject';
use Try::Tiny;

sub profiles {
      return +{
        create => { required => [qw/member_name language timezone/], },
      }
  }

EOC;
