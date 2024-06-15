#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Database creation in progress...${NC}"

# Allow the connection from any IP address from the network
sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf 

# Start the MySQL service
service mysql start

# Wait for MySQL to be fully up and running
until mysqladmin ping &>/dev/null; do
  echo -e "${GREEN}Waiting for MySQL to be up...${NC}"
  sleep 2
done

mysql -u root -p${DB_ROOT_PASSWORD} <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

echo -e "${GREEN}Database creation done.${NC}"

# Stop the service to allow the connection from any IP address from the network
kill $(cat /run/mysqld/mysqld.pid)

mysqld_safe