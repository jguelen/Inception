#!/bin/bash

set -e

printf "Launching mysqld-exporter\n"

USER=$(cat /run/secrets/db_ro_credentials | sed -n 1p | tr -d '\r')
PASSWORD=$(cat /run/secrets/db_ro_credentials | sed -n 2p | tr -d '\r')

mkdir -p /etc/mysqld-exporter/

cat >/etc/mysqld-exporter/.my.cnf <<EOF
[client]
user=$USER
password=$PASSWORD
host=mariadb
port=3306
EOF

chmod 600 /etc/mysqld-exporter/.my.cnf

exec "$@"