{
  debug => 1,
  url => {
    api => 'http://localhost:5000/api',
    explorer => 'http://localhost:5000/explorer',
    op => 'http://localhost:5000/op',
  },
  cache => {
    servers => ['127.0.0.1:11211'],
  },
  cache_session => {
    servers => ['127.0.0.1:11211'],
  },
  application_version => {
      'iOS' => {
          min => 2,
          current => 4,
    },
  },
  database => {
      master => {
          dsn => "dbi:mysql:<+ dist | lower +>_test",
          username => "dev_master",
          password => "",
      },
      slaves => [
          {
              dsn => "dbi:mysql:<+ dist | lower +>_test",
              username => "dev_slave",
              password => "",
          }
      ],
  },
  op_cookie_session => {
    namespace => 'session_op',
  }


}
