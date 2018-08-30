#!/bin/bash

NAME="docker_registry"
VOLUME="$HOME/docker_data/docker_registry"
VOLUME_REGISTRY="$VOLUME/registry"
VOLUME_CERTS="$VOLUME/certs"

# sync config
sudo mkdir -p $VOLUME_REGISTRY && sudo chmod -R 777 $VOLUME_REGISTRY

# submit to swarm master node
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    -p 443:5000 \
    -v $VOLUME_REGISTRY:/var/lib/registry \
    -v $VOLUME_CERTS:/opt/registry/ssl \
    --env REGISTRY_STORAGE_DELETE_ENABLED=true \
    --env REGISTRY_HTTP_TLS_KEY=/opt/registry/ssl/key.pem \
    --env REGISTRY_HTTP_TLS_CERTIFICATE=/opt/registry/ssl/cert.pem \
    --env REGISTRY_HTTP_TLS_CLIENTCAS_0=/opt/registry/ssl/ca.pem \
    --detach \
    --restart always \
    registry:2.6.2
