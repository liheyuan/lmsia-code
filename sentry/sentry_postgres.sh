#!/bin/bash

NAME="sentry-postgres"
VOLUME="/home/coder4/docker_data/sentry-postgres"

POSTGRES_DB_USER="sentry"
POSTGRES_DB_PASS="sentry_pass"

# make sure volume valid 
sudo mkdir -p $VOLUME && sudo chmod -R 777 $VOLUME

# kill old and run new 
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --hostname $NAME \
    --name $NAME \
    --volume "$VOLUME":/var/lib/postgresql/data \
    --env POSTGRES_USER=$POSTGRES_DB_USER \
    --env POSTGRES_PASSWORD=$POSTGRES_DB_PASS \
    --detach \
    --restart always \
    postgres:10 
