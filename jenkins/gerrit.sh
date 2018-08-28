#!/bin/bash

NAME="gerrit"
VOLUME="$HOME/docker_data/gerrit"
# config
WEB_URL='http://127.0.0.1:9002'
# ldap config
LDAP_IP="10.1.64.72"
LDAP_ACCOUNT_DN="dc=coder4,dc=com"
LDAP_ACCOUNT_PATTERN='(cn=${username})'
LDAP_SSHUSER_PATTERN='${cn}'
LDAP_FULLNAME_PATTERN='${sn}'
LDAP_QUERY_USERNAME='cn=guest,dc=coder4,dc=com'
LDAP_QUERY_PASSWORD='guest123'

# submit to local docker node 
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    -v "$VOLUME":/var/gerrit/review_site \
    -p 9002:8080 \
    -p 29418:29418 \
    -e AUTH_TYPE=LDAP \
    -e LDAP_SERVER=ldap://$LDAP_IP \
    -e LDAP_ACCOUNTBASE=$LDAP_ACCOUNT_DN \
    -e LDAP_ACCOUNTPATTERN=$LDAP_ACCOUNT_PATTERN \
    -e LDAP_ACCOUNTSSHUSERNAME=$LDAP_SSHUSER_PATTERN \
    -e LDAP_ACCOUNTFULLNAME=$LDAP_FULLNAME_PATTERN \
    -e LDAP_USERNAME=$LDAP_QUERY_USERNAME \
    -e LDAP_PASSWORD=$LDAP_QUERY_PASSWORD \
    -e WEBURL=$WEB_URL \
    --detach \
    --restart always \
    -d openfrontier/gerrit:2.15.3
