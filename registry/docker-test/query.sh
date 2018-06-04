#!/bin/bash
DR_HTTP="http://docker.coder4.com:5000"

curl $DR_HTTP/v2/_catalog
curl $DR_HTTP/v2/alpine_test/tags/list

