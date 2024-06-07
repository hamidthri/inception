FROM debian:buster

# install maridb server
RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server openssl

# copy the mariadb configuration file
COPY ./tools/script.sh /mariadb/

# Copy 50-server.cnf to /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Access rights
RUN chmod +x /mariadb/script.sh

# Expose port 3306
EXPOSE 3306

ENV DB_USER=wordpress_user \
    DB_PASSWORD=wordpress_password \
    DB_NAME=wordpress_db \
    DB_ROOT_PASSWORD=root_password
    
# Run the script
ENTRYPOINT ["/mariadb/script.sh"]

CMD ["mysqld"]