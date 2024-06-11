#!/bin/bash

# Define color codes for output
GREEN='\033[0;32m'
NC='\033[0m'

# Check if WordPress is not already installed
if [ ! -f wp-config.php ]; then
    echo -e "${GREEN}Downloading WordPress core...${NC}"
    wp core download --allow-root
fi

# Copy the sample configuration file
echo -e "${GREEN}Copying wp-config-sample.php to wp-config.php...${NC}"
cp wp-config-sample.php wp-config.php

# Replace database placeholders with environment variables
echo -e "${GREEN}Configuring wp-config.php...${NC}"
sed -i -r "s/database_name_here/$DB_NAME/" wp-config.php
sed -i -r "s/username_here/$DB_USER/" wp-config.php
sed -i -r "s/password_here/$DB_PASSWORD/" wp-config.php
sed -i -r "s/localhost/mariadb/" wp-config.php

# Modify PHP-FPM configuration to use port 9000 instead of socket
echo -e "${GREEN}Configuring PHP-FPM to listen on port 9000...${NC}"
sed -i 's|listen = /run/php/php7.3-fpm.sock|listen = 9000|g' /etc/php/7.3/fpm/pool.d/www.conf

# Wait for the database to be ready
echo -e "${GREEN}Waiting for the database to be ready...${NC}"
sleep 20

# Install WordPress
echo -e "${GREEN}Installing WordPress...${NC}"
wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root

# Create a new WordPress user
echo -e "${GREEN}Creating a new WordPress user...${NC}"
wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --allow-root

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
