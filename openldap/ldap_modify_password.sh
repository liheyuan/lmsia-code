#!/bin/bash

# const
LDAP_SERVER_IP="192.168.99.100"
LDAP_SERVER_PORT="389"
LDAP_ADMIN_USER="cn=admin,dc=coder4,dc=com"
LDAP_ADMIN_PASS="admin123"

if [ x"$#" != x"2" ];then
    echo "Usage: $0 <username> <newPassword>"
    exit -1
fi

# param
USERNAME="$1"
PASSWORD="$2"
ENCRYPT_PASSWORD=$(slappasswd -h {ssha} -s "$PASSWORD")

# modify
cat <<EOF | ldapmodify -c -h $LDAP_SERVER_IP -p $LDAP_SERVER_PORT -w $LDAP_ADMIN_PASS -D $LDAP_ADMIN_USER 
dn: cn=$USERNAME,ou=users,dc=coder4,dc=com
changetype: modify
replace: userPassword
userPassword: $ENCRYPT_PASSWORD
EOF
