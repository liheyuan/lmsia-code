#!/bin/bash

# BUILD
docker build -t slave .

NAME="slave"

# submit to local docker node 
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -p 22 \
    --detach \
    --restart always \
    -d slave:latest 
