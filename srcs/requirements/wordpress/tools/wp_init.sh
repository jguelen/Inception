#!/bin/bash

DB_PASSWORD=$(cat /run/secrets/db_password)

USER_NAME=$(sed -n 1p /run/secrets/wp_user_credentials)
USER_PASSWORD=$(sed -n 2p /run/secrets/wp_user_credentials)
USER_EMAIL=$(sed -n 3p /run/secrets/wp_user_credentials)

ADMIN_NAME=$(sed -n 1p /run/secrets/wp_admin_credentials)
ADMIN_PASSWORD=$(sed -n 2p /run/secrets/wp_admin_credentials)
ADMIN_EMAIL=$(sed -n 3p /run/secrets/wp_admin_credentials)

WP_PATH=/var/www/html
DB_HOST=mariadb

# Mandatory
printf "Downloading core...\n"
wp core download \
	--force \
	--locale=fr_FR \
	--path=$WP_PATH \
	--allow-root

printf "Creating new config file...\n"
wp config create \
	--dbname=$DB_NAME \
	--dbuser=$DB_USER \
	--dbpass=$DB_PASSWORD \
	--dbhost=$DB_HOST \
	--path=$WP_PATH \
	--allow-root

# wp config set WP_CONTENT_DIR "$WP_PATH" --allow-root

printf "Installing wp core...\n"
wp core install \
	--url=$DOMAIN_NAME \
	--title="$WP_TITLE" \
	--admin_user=$ADMIN_NAME \
	--admin_password=$ADMIN_PASSWORD \
	--admin_email=$ADMIN_EMAIL \
	--skip-email \
	--path=$WP_PATH \
	--allow-root

printf "Creating WordPress user...\n"
wp user create \
	"$USER_NAME" \
	"$USER_EMAIL" \
	--user_pass=$USER_PASSWORD \
	--role=subscriber \
	--path=$WP_PATH \
	--allow-root

# Bonus
printf "Installing redis as a plugin...\n"
wp plugin install redis-cache \
	--activate \
	--path=$WP_PATH \
	--allow-root

wp config set WP_REDIS_PORT 6379\
	--raw \
	--type=constant \
	--path=$WP_PATH \
	--allow-root

wp config set WP_REDIS_HOST redis\
	--type=constant \
	--path=$WP_PATH \
	--allow-root

printf "Enabling redis...\n"
wp redis enable \
	--path=$WP_PATH \
	--allow-root	