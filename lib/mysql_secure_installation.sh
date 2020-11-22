#!/usr/bin/env bash

echo "SET PASSWORD FOR root@localhost = PASSWORD('$1');"

mysql -e "SET PASSWORD FOR root@localhost = PASSWORD('$1');"
mysql -e "DELETE FROM mysql.user WHERE User='';"
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
mysql -e "DROP DATABASE IF EXISTS test;"
