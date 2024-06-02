<?php

define( 'DB_NAME', getenv('MYSQL_NAME') );

define( 'DB_USER', getenv('MYSQL_USER') );

define( 'DB_PASSWORD', getenv('MYSQL_PASSWORD') );

define( 'DB_HOST', 'mariadb' ); // Use the service name defined in docker-compose.yml

define( 'DB_CHARSET', 'utf8' );

define( 'DB_COLLATE', '' );

define('WP_CACHE', true);

$table_prefix = 'wp_';

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';

?>
