#!/bin/bash

# Define color codes for output
GREEN='\033[0;32m'
NC='\033[0m'
RESET='\033[0m'


if [ -e /var/www/html/wp-config.php ]; then
	echo -e "${GREEN}Wordpress config file (wp-config.php) already exists.${RESET}"

else
    echo -e "${GREEN}Wordpress config file (wp-config.php) does not exist.${RESET}"
    echo -e "${GREEN}Downloading Wordpress core...${RESET}"
    wp core download --allow-root

    echo -e "${GREEN}Creating wp-config.php file...${RESET}"
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=mariadb --allow-root
fi



# Modify PHP-FPM configuration to use port 9000 instead of socket
echo -e "${GREEN}Configuring PHP-FPM to listen on port 9000...${NC}"
sed -i 's|listen = /run/php/php7.3-fpm.sock|listen = 9000|g' /etc/php/7.3/fpm/pool.d/www.conf

# Wait for the database to be ready
echo -e "${GREEN}Waiting for the database to be ready...${NC}"
sleep 20


# Check if WordPress is already installed
if $(wp core is-installed --allow-root); then
    echo -e "${GREEN}WordPress is already installed.${NC}"
else #install WordPress
    echo -e "${GREEN}Installing WordPress...${NC}"
    wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
    echo -e "${GREEN}Creating a new WordPress user...${NC}"
    wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD  --allow-root
fi

# Update WordPress home and site URL
echo -e "${GREEN}Updating WordPress home and site URL to https://localhost...${NC}"
wp option update home "https://localhost" --allow-root
wp option update siteurl "https://localhost" --allow-root

# Ensure the uploads directory has the correct permissions
echo -e "${GREEN}Setting correct permissions for the uploads directory...${NC}"
chmod -R 755 wp-content/uploads
chown -R www-data:www-data wp-content/uploads

# Start PHP-FPM in the foreground
echo -e "${GREEN}Starting PHP-FPM...${NC}"
php-fpm7.3 -F
