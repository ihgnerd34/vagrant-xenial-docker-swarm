#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install -y software-properties-common apt-transport-https
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
sudo apt-get update
sudo apt-get install -y docker-ce --allow-unauthenticated
sudo usermod -aG docker vagrant
docker version
