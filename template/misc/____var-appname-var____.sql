create table member (
       member_id int unsigned not null auto_increment,
       member_name varchar(255) NOT NULL,
       language varchar(5) NOT NULL,
       timezone varchar(100) NOT NULL,
       last_active_at DATETIME NOT NULL,
       on_active tinyint unsigned not null,
       updated_at TIMESTAMP NOT NULL,
       created_at DATETIME NOT NULL,
       PRIMARY KEY (member_id),
       KEY(last_active_at)
) ENGINE=InnoDB DEFAULT CHARACTER SET = 'utf8';

create table auth_terminal (
      member_id int unsigned not null,
      terminal_code varchar(255) not null,
      terminal_type tinyint not null,
      terminal_info varchar(255) not null,
      updated_at TIMESTAMP NOT NULL,
      created_at DATETIME NOT NULL,
      PRIMARY KEY (terminal_code),
      INDEX(member_id)
) ENGINE=InnoDB DEFAULT CHARACTER SET = 'utf8';

create table auth_access_token (
      member_id int unsigned not null,
      access_token varchar(255) not null,
      updated_at TIMESTAMP NOT NULL,
      created_at DATETIME NOT NULL,
      PRIMARY KEY (access_token),
      KEY (member_id)
) ENGINE=InnoDB DEFAULT CHARACTER SET = 'utf8';

create table operator (
  operator_id int unsigned not null auto_increment,
  op_name          varchar(255) not null,
  email            varchar(255) not null,
  password         varchar(255) NOT NULL,
  op_timezone      varchar(255) NOT NULL,
  op_language varchar(5) NOT NULL,
  acl_token        varchar(255) NOT NULL,
  on_active tinyint unsigned not null,
  updated_at       TIMESTAMP    NOT NULL,
  created_at       DATETIME     NOT NULL,
  PRIMARY KEY(operator_id),
  UNIQUE(email)
) ENGINE=InnoDB DEFAULT CHARACTER SET = 'utf8';

create table operation_log (
  operation_log_id int unsigned not null auto_increment,
  operator_id int unsigned not null,
  operation_type int unsigned not null,
  criteria_code varchar(100) not null,
  attributes_dump TEXT not null,
  operation_memo TEXT,
  updated_at       TIMESTAMP    NOT NULL,
  created_at       DATETIME     NOT NULL,
  PRIMARY KEY (operation_log_id),
  INDEX(operator_id),
  INDEX(operation_type,criteria_code)
) ENGINE=InnoDB DEFAULT CHARACTER SET = 'utf8';
