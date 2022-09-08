CREATE USER 'guest'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';
GRANT ALL
  ON *.*
  TO 'guest'@'localhost'
  WITH GRANT OPTION;
  