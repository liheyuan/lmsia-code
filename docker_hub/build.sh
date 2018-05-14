#!/bin/bash

PROJECT_NAME="lmsia-abc"
SERVER_NAME="$PROJECT_NAME-server"
GRADLE_BIN="/opt/gradle/bin/gradle"

# Clone code
git clone git@github.com:liheyuan/$PROJECT_NAME.git 

# Build 
cd $PROJECT_NAME 
$GRADLE_BIN build

# Copy jar
cp $SERVER_NAME/build/libs/*jar ../$SERVER_NAME.jar
cd ..

# Build
docker build -t ${SERVER_NAME} .

# Clean
rm -rf ${PROJECT_NAME}

# Push to dockerhub.io
docker tag $SERVER_NAME coder4/$SERVER_NAME:latest
docker push coder4/$SERVER_NAME:latest
