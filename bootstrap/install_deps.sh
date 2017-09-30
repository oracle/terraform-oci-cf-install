#!/usr/bin/env bash
set -e

while fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do
    sleep 0.5
done

sudo apt-get update -y
sudo apt-get install -y make ruby
sudo curl -o /usr/local/bin/bosh https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.39-linux-amd64
sudo chmod +x /usr/local/bin/bosh
