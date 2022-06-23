#!/bin/bash

set -x
pwd
echo "$@"
/entrypoint.sh "$@" &
sleep 10
echo "Using password ${MYSQL_ROOT_PASSWORD}"
# while ! mysqladmin ping -u root -p${MYSQL_ROOT_PASSWORD} --silent; do
#     echo "Waiting for mysqld to be alive...sleeping for 1 second...using password ${MYSQL_ROOT_PASSWORD}"
#     sleep 1
# done
# echo "importing DB using password ${MYSQL_ROOT_PASSWORD}"
# mysql -u root -p${MYSQL_ROOT_PASSWORD} < /users.sql
tail -f /dev/null