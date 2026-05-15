#!/bin/bash

set -eux

if [ -f mariadb_initialized ] 
then
    printf "Database already exists\n"
else
    printf "Installing and initializing database\n"
    mariadb-install-db 
    ./database_init.sh&
    echo "Done" > mariadb_initialized
fi

exec "$@"