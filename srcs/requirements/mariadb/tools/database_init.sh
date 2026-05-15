#!/bin/bash

for i in {1..10}; do
    sleep 3
    mariadb < init.sql && printf "Successfully initiated database\n" && exit 0
done

printf "Failed to create and init the Database\n"
exit 1