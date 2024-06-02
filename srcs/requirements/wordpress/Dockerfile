FROM debian:buster

WORKDIR /wordpress

# Install necessary packages including Apache
RUN apt-get update && \
    apt-get install -y apache2 php-mysql php-fpm curl mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Enable Apache modules required for WordPress
RUN a2enmod rewrite

# Copy the init.sh script and set permissions
COPY ./tools/init.sh /wordpress/init.sh
RUN chmod +x /wordpress/init.sh

# Copy the PHP-FPM pool configuration file
COPY ./www.conf /etc/php/7.3/fpm/pool.d/

# Set the entrypoint
CMD ["/wordpress/init.sh"]
