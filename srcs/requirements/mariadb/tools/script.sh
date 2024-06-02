#!/bin/bash

# Start MariaDB service
service mysql start

# Create database and user, grant privileges
echo "CREATE DATABASE IF NOT EXISTS ${MYSQL_NAME} ; \
      CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}' ; \
      GRANT ALL PRIVILEGES ON ${MYSQL_NAME}.* TO '${MYSQL_USER}'@'%' ; \
      FLUSH PRIVILEGES;" > /etc/mysql/init.sql

# Run the initialization script
/usr/bin/mysqld --init-file=/etc/mysql/init.sql

# Keep the container running
tail -f /dev/null
