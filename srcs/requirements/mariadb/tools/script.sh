#!/bin/bash

echo -e "Starting Mariadb service..."
service mysql start

# Create the wordpress database
echo "FLUSH PRIVILEGES;
CREATE USER '$DB_USER'@'WP_HOST' IDENTIFIED BY '$DB_PASSWORD';
CREATE DATABASE $DB_NAME;
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'WP_HOST';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
FLUSH PRIVILEGES;" > etc/mysql/init.sql

chmod 755 etc/mysql/init.sql  # Set appropriate permissions

# Use mysqld for initialization (assuming it's available) what does below command do? It initializes the data directory and creates the system tables that it contains, if they do not exist.
mysqld --initialize-file < etc/mysql/init.sql

echo -e "Mariadb and wordpress database are successfully initialized."

rm -rf etc/mysql/init.sql

