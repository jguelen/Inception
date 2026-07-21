#!/bin/bash

set -e

DATADIR="/var/lib/mysql"
MARKER="$DATADIR/.mariadb_configured"


chown -R mysql:mysql /var/log/mysql /run/mysqld "$DATADIR"


if [ -f "$MARKER" ]; then
    printf "Database already configured. Skipping setup.\n"
else
    printf "Installing and initializing database\n"

    if [ ! -d "$DATADIR/mysql" ] || [ -z "$(ls -A "$DATADIR/mysql" 2>/dev/null)" ]; then
        mariadb-install-db --user=mysql --datadir="$DATADIR"
    fi

    (./database_init.sh && touch "$MARKER" && chown mysql:mysql "$MARKER") &
fi

exec "$@"