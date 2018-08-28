#!/bin/bash

# BUILD
docker build -t slave .

NAME="slave"
VOLUME="$HOME/docker_data/slave"

# submit to local docker node 
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    -v "$VOLUME":/var/gerrit/review_site \
    -p 22 \
    --detach \
    --restart always \
    -d slave:latest 
