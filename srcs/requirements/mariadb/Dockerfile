# Use the Debian Buster base image
FROM debian:buster

# Set the working directory
WORKDIR /mariadb

# Update package lists and install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server && apt-get clean

# Copy the script into the container
COPY ./tools/script.sh /usr/local/bin/
COPY ./conf/50-server.cnf /etc/mysql/my.cnf

# Set execute permissions on the script
RUN chmod +x /usr/local/bin/script.sh

# Specify the command to run the script
CMD ["bash", "/usr/local/bin/script.sh"]
