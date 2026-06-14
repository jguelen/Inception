#!/bin/bash

set -eux

chown -R mysql:mysql /var/log/mysql
chown -R mysql:mysql /run/mysqld

if [ -d "/var/lib/mysql/mysql" ] 
then
    printf "Database already exists. Skipping setup.\n"
else
    printf "Installing and initializing database\n"
    mariadb-install-db 
    ./database_init.sh&
#    wait $!
fi

exec "$@"