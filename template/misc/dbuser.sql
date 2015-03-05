CREATE USER 'dev_master'@'localhost' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON * . * TO 'dev_master'@'localhost';
CREATE USER 'dev_slave'@'localhost' IDENTIFIED BY '';
GRANT SELECT ON * . * TO 'dev_slave'@'localhost';
