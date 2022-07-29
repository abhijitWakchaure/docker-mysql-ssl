#!/usr/bin/env bash
# Author: Abhijit Wakchaure <awakchau@tibco.com>

set -x
sudo apt update && sudo apt upgrade

echo "Installing docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

echo "Installing docker-compose..."
sudo curl -SL https://github.com/docker/compose/releases/download/v2.7.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

logout