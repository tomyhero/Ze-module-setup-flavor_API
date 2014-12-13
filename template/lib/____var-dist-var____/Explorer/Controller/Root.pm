package <+ dist +>::Explorer::Controller::Root;
use Ze::Class;
extends '<+ dist +>::WAF::Controller';

use <+ dist +>X::Config;
use <+ dist +>X::Util;
use <+ dist +>X::Home;
use <+ dist +>::Data::AuthAccessToken;
use Furl;
use <+ dist +>X::Doc::API;

sub index {
  my ($self,$c)  = @_;
  my $doc = <+ dist +>X::Doc::API->new();
  $c->stash->{doc} = $doc->get_list;
}

sub proxy {
  my ($self,$c) = @_; 

  my $furl = Furl->new();
  my $config = <+ dist +>X::Config->instance();
  my $url = $config->get('url')->{api} .   $c->req->param('path');


  my $data = <+ dist +>X::Util::from_json($c->req->param('args') || '{}');

  my $res = $furl->post(
     $url,  
     [ 
         'X-ACCESS-TOKEN' => $c->req->param('access_token'),
         'X-INTERNAL-ACCESS-TOKEN' => $c->req->param('internal_token'),

     ],
     $data,
  );
  $c->res->body($res->body);
}

sub doc {
  my ($self,$c) = @_; 
  $c->view_type('JSON');
  my $doc = <+ dist +>X::Doc::API->new();
  my $item = $doc->get($c->req->as_fdat->{path} || '') || {};
  $c->set_json_stash({item => $item });
}

1;
