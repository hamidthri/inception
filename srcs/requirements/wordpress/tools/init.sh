#!/bin/bash

# Wait for MariaDB to be ready
while ! mysqladmin ping -hmariadb --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

# Download and configure WordPress if not already present
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Setting up WordPress..."

    # Download WP-CLI
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    # Install WordPress
    wp core download --path=/var/www/html --allow-root
    wp config create --path=/var/www/html --dbname=$MYSQL_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --dbprefix=wp_ --allow-root

    # Install the WordPress database
    wp core install --path=/var/www/html --url=$DOMAIN_NAME --title="$WP_TITLE" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --path=/var/www/html --allow-root
fi

# Set the correct permissions
chown -R www-data:www-data /var/www/html

