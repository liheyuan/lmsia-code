#!/bin/bash

# const
LDAP_SERVER_IP="192.168.99.100"
LDAP_SERVER_PORT="389"
LDAP_ADMIN_USER="cn=admin,dc=coder4,dc=com"
LDAP_ADMIN_PASS="admin123"

if [ x"$#" != x"3" ];then
    echo "Usage: $0 <username> <password> <realname>"
    exit -1
fi

# param
USERNAME="$1"
PASSWORD="$2"
ENCRYPT_PASSWORD=$(slappasswd -h {ssha} -s "$PASSWORD")
REALNAME="$3"
REALNAME_BASE64=$(echo -n $REALNAME | base64)

# modify
cat <<EOF | ldapmodify -c -h $LDAP_SERVER_IP -p $LDAP_SERVER_PORT -w $LDAP_ADMIN_PASS -D $LDAP_ADMIN_USER 
dn: cn=$USERNAME,ou=users,dc=coder4,dc=com
changetype: add
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: inetOrgPerson
cn: $USERNAME
sn:: $REALNAME_BASE64
mail: $USERNAME@coder4.com
userPassword: $ENCRYPT_PASSWORD

dn: cn=Users,ou=groups,dc=coder4,dc=com
changetype: modify
add: uniqueMember
uniqueMember: cn=$USERNAME,ou=users,dc=coder4,dc=com
EOF
