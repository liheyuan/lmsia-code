#!/bin/bash

NAME="sentry-worker"
REDIS_LINK="sentry-redis:redis"
POSTGRES_LINK="sentry-postgres:postgres"

SENTRY_SECRET="q5%_k4t#w#43rlnd(mr1ms%p8(mjofh9z&4al8d1q&a3f#19_d"

# kill old and run new 
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --hostname $NAME \
    --name $NAME \
    --env SENTRY_SECRET_KEY=$SENTRY_SECRET \
    --detach \
    --restart always \
    --link $REDIS_LINK \
    --link $POSTGRES_LINK \
    sentry:9 run worker
