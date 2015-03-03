{
  debug => 1,
  url => {
    api => 'http://localhost:5000/api',
    explorer => 'http://localhost:5000/explorer',
    op => 'http://localhost:5000/op',
  },
  database => {
      master => {
          dsn => "dbi:mysql:<+ dist | lower +>_local",
          username => "dev_master",
          password => "",
      },
      slaves => [
          {
              dsn => "dbi:mysql:<+ dist | lower +>_local",
              username => "dev_slave",
              password => "",
          }
      ],
  },
}
