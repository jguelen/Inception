#!/bin/bash

if [ ! -f "/var/www/html/wp-config.php" ]; then
	./wp_init.sh
fi

chown -R www-data:www-data /var/www/html 
chown -R 755 /var/www/html 

exec "$@"
# sleep infinity