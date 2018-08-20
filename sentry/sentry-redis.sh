#!/bin/bash

NAME="sentry-redis"
VOLUME="/home/coder4/docker_data/sentry-redis"

# make sure volume valid 
sudo mkdir -p $VOLUME && sudo chmod -R 777 $VOLUME

# kill old and run new 
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --hostname $NAME \
    --name $NAME \
    --volume "$VOLUME":/data \
    --detach \
    --restart always \
    redis:4 
