{
  database => {
      master => {
          dsn => "dbi:mysql:<+ dist | lower +>_tteranishi",
          username => "dev_master",
          password => "",
      },
      slaves => [
          {
              dsn => "dbi:mysql:<+ dist | lower +>_tteranishi",
              username => "dev_slave",
              password => "",
          }
      ],
  },
}
