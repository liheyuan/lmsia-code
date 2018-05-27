#!/bin/bash

# const
LDAP_SERVER_IP="192.168.99.100"
LDAP_SERVER_PORT="389"
LDAP_ADMIN_USER="cn=admin,dc=coder4,dc=com"
LDAP_ADMIN_PASS="admin123"

if [ x"$#" != x"1" ];then
    echo "Usage: $0 <username>"
    exit -1
fi

# param
USERNAME="$1"

# delete user 
ldapdelete -c -h $LDAP_SERVER_IP -p $LDAP_SERVER_PORT -w $LDAP_ADMIN_PASS -D $LDAP_ADMIN_USER "cn=$USERNAME,ou=users,dc=coder4,dc=com"
