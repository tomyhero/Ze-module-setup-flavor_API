package <+ dist +>X::Doc::API;
use strict;
use warnings;
use Ze::Class;
use <+ dist +>X::Home;

has 'data' => ( is => 'rw');

sub BUILD {
  my $self = shift;
  my $home = <+ dist +>X::Home->instance();
  my $doc = do $home->file('doc/api.pl');
  $self->data($doc);
}

sub get {
  my $self = shift;
  my $path = shift;

  for my $g (@{$self->data}){
      for my $i ( @{$g->{list}} ){
        return $i if $i->{path} eq $path;
      }
  }
  return ;
}

sub get_list {
  my $self = shift;
  my @groups = ();

  for my $g (@{$self->data}){

    my $group  = {
      name => $g->{name},
    };

    my @items = ();
    for my $i ( @{$g->{list}} ){
        my $item = {
          path => $i->{path},
          description => $i->{description},
        };
        push @items,$item;
    }
    $group->{items} = \@items;
    push @groups,$group;
  }

  return \@groups;
}

EOC;
