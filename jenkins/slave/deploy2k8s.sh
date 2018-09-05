#!/bin/bash
set -e

if [ x"$#" != x"2" ];then
    echo "Usage $0 proj_name img_version"
    exit -1
fi

# Const
DOCKER_REGISTRY="10.1.64.72"
PROJECT_NAME=$1
IMAGE_NAME=$(echo $PROJECT_NAME | sed -r 's/-deploy$//g')
IMAGE_VERSION=$2

# Generate yaml 
cat > ./deployment.yaml <<EOF

apiVersion: apps/v1
kind: Deployment
metadata:
  name: $IMAGE_NAME-deployment
spec:
  selector:
    matchLabels:
      app: $IMAGE_NAME 
  replicas: 2
  template:
    metadata:
      labels:
        app: $IMAGE_NAME
    spec:
      containers:
      - name: $IMAGE_NAME-ct
        image: $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_VERSION
        ports:
        - containerPort: 8080
        - containerPort: 3000

EOF

# Deploy 
kubectl apply -f ./deployment.yaml
