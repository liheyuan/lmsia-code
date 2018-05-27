# README.md

# admin
ldapwhoami -h 192.168.99.100 -p 389 -D "cn=admin,dc=coder4,dc=com" -w admin123
# read only user
ldapwhoami -h 192.168.99.100 -p 389 -D "cn=guest,dc=coder4,dc=com" -w guest123

# add or modify
ldapadd -h 192.168.99.100 -p 389 -w admin123 -D "cn=admin,dc=coder4,dc=com" -f ./users.ldif
