my $router = router {
  submapper( '/', { controller => 'Root' } )
    ->connect( '', { action => 'index' } )
    ->connect( 'proxy', { action => 'proxy' } )
    ->connect( 'doc', { action => 'doc' } )
  ;
};

return $router;
