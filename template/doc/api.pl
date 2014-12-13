use utf8;
use strict;
use warnings; 

return +[
    {
      name => "Basic",
      list => 
      [
        {
          description => "get application information such as versions",
          path => '/app/info',
          requests => {},
          response => {},
          custom_errors => {}
        }  
      ],
    },
    {
      name => "Member Basic",
      list => 
      [
      {
        description => "make member account on system",
        path => "/app/auth_terminal/register",
        requests => {
            member_name => 'member name',
            language => 'language',
            timezone  => 'timezone',
            terminal_type  => 'terminal type',
            terminal_info => 'terminal info'
        },
        response => {
          'item.member_id' => '',
          'item.language' => '',
          'item.terminal_code' => ''
        },
        custom_errors => {}
      },
      {
        description => "login and get access_token",
        path => "/app/auth_terminal/login",
        requests => {
          terminal_code => '', 
        },
        response => {
          'item.access_token' => 'access token', 
        },
        custom_errors => {
          login_fail => 'throw when login fail',
        }
      },
      {
        description => "get member current basic info",
        path => "/app/member/me",
        requests => {},
        response => {
            "item.member_id" => "member id",
        }, 
        custom_errors => {}
      },
    ]
  },
];
