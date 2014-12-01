my $terminal_type = '/{frontend:(?:app|web)}';

my $router = router {
    submapper($terminal_type . '/', {controller => 'Root'})
            ->connect('info', {action => 'info' })
    ;

    submapper('/app/auth_terminal/', {controller => 'AuthTerminal'})
      ->connect('register', {action => 'register' })
      ->connect('login', {action => 'login' })
    ;

    submapper($terminal_type . '/member/', {controller => 'Member'})
      ->connect('me', {action => 'me' })
    ;

}
