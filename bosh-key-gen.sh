#!/usr/bin/env bash
set -e

# Generate SSH keypair for shell access to bastion instance.
ssh-keygen -f keys/bosh-ssh

# Generate OCI API Key for bosh user.
openssl genrsa -out ./keys/bosh-api-private-key.pem 2048
chmod go-r ./keys/bosh-api-private-key.pem
openssl rsa -pubout -in ./keys/bosh-api-private-key.pem -out ./keys/bosh-api-public-key.pem
openssl rsa -pubout -outform DER -in ./keys/bosh-api-private-key.pem | openssl md5 -c > ./keys/bosh-api-fingerprint

# Generate SSL Certificates for Load Balancers.
openssl genrsa -des3 -out ./keys/lb-ssl.key 2048
openssl rsa -in ./keys/lb-ssl.key -out ./keys/lb-ssl.key
openssl req -new -key ./keys/lb-ssl.key -out ./keys/lb-ssl.csr
openssl x509 -req -days 365 -in ./keys/lb-ssl.csr -signkey ./keys/lb-ssl.key -out ./keys/lb-ssl.crt
