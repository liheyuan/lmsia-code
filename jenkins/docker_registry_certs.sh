#!/bin/bash

NAME="docker_registry_certs"
VOLUME="$HOME/docker_data/docker_registry/certs"
SSL_IP="10.1.64.72"

# make sure volume valid 
sudo mkdir -p $VOLUME && sudo chmod -R 777 $VOLUME

# submit to swarm master node
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run --rm \
  --name $NAME \
  -v $VOLUME:/certs \
  -e SSL_IP=$SSL_IP \
  -e SSL_DNS=registry.local \
  paulczar/omgwtfssl
