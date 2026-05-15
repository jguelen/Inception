CREATE DATABASE IF NOT EXISTS `${DB_NAME}`;
CREATE USER IF NOT EXISTS `${DB_USER}`@'%' IDENTIFIED BY '$(cat /run/secrets/db_password)';
GRANT ALL PRIVILEGES ON `${DB_NAME}`.* TO `${DB_USER}`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat /run/secrets/db_root_password)';
FLUSH PRIVILEGES;