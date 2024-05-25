#!/bin/bash

service mysql start


# create database if not exists
echo "CREATE DATABASE IF NOT EXISTS $db_name;" > db.sql
echo "CREATE USER IF NOT EXISTS '$db_user'@'%' IDENTIFIED BY '$db_password';" >> db.sql
echo "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%';" >> db.sql
echo "ALTER USER 'USER'@'localhost' IDENTIFIED BY 'PASSWORD';" >> db.sql
echo "FLUSH PRIVILEGES;" >> db.sql

mysql < db.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
