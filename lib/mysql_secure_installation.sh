#!/usr/bin/env bash

#Set root password as first argument
#Delete anonymous users
#Disallow root login remotely
#Remove test database

mysql -e "SET PASSWORD FOR root@localhost = PASSWORD('$1');"
mysql -e "DELETE FROM mysql.user WHERE User='';"
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
mysql -e "DROP DATABASE IF EXISTS test;"
mysql -e "FLUSH PRIVILEGES;"
