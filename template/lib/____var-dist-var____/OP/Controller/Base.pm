package <+ dist +>::OP::Controller::Base;

use Ze::Class;
extends '<+ dist +>::WAF::Controller';
use <+ dist +>::Authorizer::Operator;
use <+ dist +>X::Config;
use <+ dist +>X::DateTime;
use <+ dist +>X::Constants;
use <+ dist +>::OP::I18N;
use Text::Xslate::Util;

__PACKAGE__->add_trigger(
  BEFORE_EXECUTE => sub {
    my ( $self, $c, $action ) = @_;
  my $now = <+ dist +>X::DateTime->now();
  $c->requested_at($now);
  $c->stash->{requested_at} = $now;
  %{$c->stash->{constants}} = ( %{<+ dist +>X::Constants::as_hashref()}, %{<+ dist +>::OP::ACL::as_hashref()} );
  $c->stash->{config} = <+ dist +>X::Config->instance;
  $c->stash->{support_op_timezones} = <+ dist +>X::Util::support_op_timezones;
  $c->stash->{support_op_languages} = <+ dist +>X::Util::support_op_languages;


  # default. do nothing
  $c->stash->{loc} = sub { return shift; };
  $c->stash->{loc_row} = sub { return shift; };
    
  return if ($c->req->path =~ /^\/auth\//);


  my $authorizer = <+ dist +>::Authorizer::Operator->new( c => $c );
  if( my $operator_obj = $authorizer->authorize() ){
      $c->operator_obj($operator_obj);
      $c->stash->{operator_obj} = $operator_obj;


      my $i18n = <+ dist +>::OP::I18N->get_handle($operator_obj->op_language);

      $c->stash->{loc} = sub {
          my $text = shift;
          my @args = @_;
          return $i18n->maketext( $text, @args ) ;
      };

      $c->stash->{loc_raw} = Text::Xslate::Util::html_builder {
          my $format = shift;
          my @args = map { Text::Xslate::Util::html_escape($_) } @_;
          return $i18n->maketext($format, @args);
      };

  }
  else {
      $c->redirect('/auth/login');
      $c->abort();
  }

  $c->on_fillin(1);
  $c->stash->{fdat} = $c->req;


});


EOC;
