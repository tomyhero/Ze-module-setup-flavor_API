my $route = router {
  submapper( '/', { controller => 'Root' } )
    ->connect( '', { action => 'index' } )
  ;

  submapper( '/auth/', { controller => 'Auth' } )
    ->connect( 'login', { action => 'login' } )
    ->connect( 'logout', { action => 'logout' } )
  ;

  submapper( '/member/', { controller => 'Member' } )
    ->connect( '', { action => 'index' } )
  ;

  submapper( '/my/operator/', { controller => 'My::Operator' } )
    ->connect( '', { action => 'index' } )
    ->connect( 'edit', { action => 'edit' } )
    ->connect( 'edit_password', { action => 'edit_password' } )
  ;

  submapper( '/admin/operator/', { controller => 'Admin::Operator' } )
    ->connect( '', { action => 'index' } )
    ->connect( 'add', { action => 'add' } )
    ->connect( '{operator_id:[0-9]+}/edit', { action => 'edit' } )
    ->connect( '{operator_id:[0-9]+}/', { action => 'detail' } )
  ;

  submapper( '/admin/operation_log/', { controller => 'Admin::OperationLog' } )
    ->connect( '', { action => 'index' } )
    ->connect( '{operation_log_id:[0-9]+}/', { action => 'detail' } )
  ;

};

return $route;
