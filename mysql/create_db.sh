#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage $0 <dbname>"
    exit -1
fi

DB_NAME=$1
DB_USER="lmsia"
DB_PASS="pass"

echo "CREATE DATABASE IF NOT EXISTS $DB_NAME DEFAULT CHARSET utf8 COLLATE utf8_general_ci;"
echo "CREATE USER $DB_USER IDENTIFIED by '$DB_PASS';"
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* to $DB_USER;"
echo "FLUSH PRIVILEGES;"

