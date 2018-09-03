#!/bin/bash
set -e

# Const
DOCKER_REGISTRY="10.1.64.72"
PROJECT_VERSION=${BUILD_NUMBER:-1}
PROJECT_NAME=$(basename `pwd`| sed -r 's/-build$//g')
SERVER_NAME="$PROJECT_NAME-server"
JAR_NAME="$SERVER_NAME.jar"
DOCKER_FULLNAME="$PROJECT_NAME:$PROJECT_VERSION"

# Copy Jar
find . -name "$SERVER_NAME*.jar" -exec cp {} ./$JAR_NAME \;

# Generate Dockerfile
cat > ./Dockerfile <<EOF
FROM anapsix/alpine-java:8_server-jre

VOLUME /tmp /app
WORKDIR /app
EXPOSE 8080 3000
COPY ${JAR_NAME} /app
CMD ["java", "-jar", "/app/${JAR_NAME}"]

EOF

# Build
docker build .
docker build -t $PROJECT_NAME .
docker tag $PROJECT_NAME $DOCKER_REGISTRY/$DOCKER_FULLNAME
docker push $DOCKER_REGISTRY/$DOCKER_FULLNAME
