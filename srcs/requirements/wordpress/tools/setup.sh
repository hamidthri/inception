#!/bin/bash

DB_NAME="wordpress"
DB_USER="wp_user"
DB_PASSWORD="wp_password"
DB_HOST="mariadb"
WP_USER_ROLE="editor"

DOMAIN_NAME="example.com"
WP_TITLE="My WordPress Site"
WP_ADMIN_USER="admin"
WP_ADMIN_PASSWORD="admin"
WP_ADMIN_EMAIL="admin@example.com"
WP_USER="user"
WP_PASSWORD="password"

WP_PATH="/var/www/html"

if [ ! -f "$WP_PATH/wp-load.php" ]; then
  echo -e "${GREEN}Downloading WordPress core files..."
  wp core download --path="$WP_PATH" --allow-root
fi

if [ ! -e "$WP_PATH/wp-config.php" ]; then
  echo -e "${GREEN}Creating wp-config.php file..."
  wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="$DB_HOST" --path="$WP_PATH" --allow-root
fi

su - www-data -s /bin/bash <<EOF
wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --path="$WP_PATH"
wp user create "$WP_USER" "$WP_ADMIN_EMAIL" --user_pass="$WP_PASSWORD" --role=$WP_USER_ROLE --path="$WP_PATH"
EOF

echo -e "${GREEN}WordPress setup is complete!"

exec "$@"
