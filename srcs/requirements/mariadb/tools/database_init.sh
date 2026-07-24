#!/bin/bash

DB_PASS=$(cat /run/secrets/db_password | tr -d '\r')
DB_ROOT_PASS=$(cat /run/secrets/db_root_password | tr -d '\r')
EXPORTER=$(cat /run/secrets/db_ro_credentials | sed -n 1p | tr -d '\r')
EXPORTER_PASSWORD=$(cat /run/secrets/db_ro_credentials | sed -n 2p | tr -d '\r')

echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME};" > init.sql
echo "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';" >> init.sql
echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';" >> init.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';" >> init.sql
echo "CREATE USER IF NOT EXISTS '${EXPORTER}'@'%' IDENTIFIED BY '${EXPORTER_PASSWORD}';" >> init.sql
echo "GRANT PROCESS, REPLICATION CLIENT, SLAVE MONITOR, SELECT ON *.* TO '${EXPORTER}'@'%';" >> init.sql
echo "FLUSH PRIVILEGES;" >> init.sql

#echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" > init.sql
#echo "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '$(cat /run/secrets/db_password)';" >> init.sql
#echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '$(cat /run/secrets/db_password)';" >> init.sql
#echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat /run/secrets/db_root_password)';" >> init.sql
#echo "CREATE USER IF NOT EXISTS '${EXPORTER}'@'%' IDENTIFIED BY '${EXPORTER_PASSWORD}';" >> init.sql
#echo "GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO '${EXPORTER}'@'%';" >> init.sql
#echo "FLUSH PRIVILEGES;" >> init.sql

for i in {1..10}; do
    sleep 3
    #mariadb -uroot --protocol=socket < init.sql && printf "Successfully initiated database\n" && exit 0
    mariadb -uroot < init.sql \
        && printf "Successfully initiated database\n" \
        && rm -f init.sql \
        && exit 0
done

printf "Failed to create and init the Database\n"
exit 1