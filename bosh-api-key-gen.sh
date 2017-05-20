#!/usr/bin/env bash
set -e

openssl genrsa -out ./keys/bosh-api-private-key.pem 2048
chmod go-r ./keys/bosh-api-private-key.pem
openssl rsa -pubout -in ./keys/bosh-api-private-key.pem -out ./keys/bosh-api-public-key.pem
openssl rsa -pubout -outform DER -in ./keys/bosh-api-private-key.pem | openssl md5 -c > ./keys/bosh-api-fingerprint
