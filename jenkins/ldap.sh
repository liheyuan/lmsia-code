#!/bin/bash

NAME="ldap"
VOLUME="$HOME/docker_data/ldap"
VOLUME_DATA="$VOLUME/data"
VOLUME_CONFIG="$VOLUME/config"
DOMAIN="coder4.com"
ADMIN_PASS="admin123"
LDAP_READONLY_USER="guest"
LDAP_READONLY_PASS="guest123"

# make sure volume valid 
sudo mkdir -p $VOLUME_DATA && sudo chmod -R 777 $VOLUME_DATA
sudo mkdir -p $VOLUME_CONFIG && sudo chmod -R 777 $VOLUME_CONFIG

# submit to swarm master node
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    -p 389:389 \
    -p 636:636 \
    --volume "$VOLUME_DATA":/var/lib/ldap \
    --volume "$VOLUME_CONFIG":/etc/ldap/slapd.d \
    --env LDAP_TLS=false \
    --env LDAP_DOMAIN=$DOMAIN \
    --env LDAP_ADMIN_PASSWORD=$ADMIN_PASS \
    --env LDAP_READONLY_USER=true \
    --env LDAP_READONLY_USER_USERNAME=$LDAP_READONLY_USER \
    --env LDAP_READONLY_USER_PASSWORD=$LDAP_READONLY_PASS \
    --detach \
    --restart always \
    osixia/openldap:1.2.1
