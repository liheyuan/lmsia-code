#!/bin/bash
DR_USER="test"
DR_PASS="pass"
DR_DOMAIN="docker.coder4.com:5000"
docker login -u $DR_USER -p $DR_PASS $DP_DOMAIN 
docker build -t alpine_test .
docker tag alpine_test $DR_DOMAIN/alpine_test:test_1.0
docker push $DR_DOMAIN/alpine_test

