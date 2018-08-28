#!/bin/bash
NAME="jenkins"
VOLUME="$HOME/docker_data/jenkins"

# ensure volume ready
sudo mkdir -p $VOLUME
sudo chmod -R 777 $VOLUME

# submit to local docker node 
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    -v $VOLUME:/var/jenkins_home \
    -p 9001:8080 \
    -p 50000:50000 \
    --detach \
    --restart always \
    jenkins/jenkins:2.60.3-alpine

