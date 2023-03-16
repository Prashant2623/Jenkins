#!/bin/bash

# Install Docker 
sudo yum update -y && sudo yum install -y docker
sudo systemctl start docker
sudo usermod  -aG  docker ec2-user

# Docker login
export DOCKER_USER=$1
export DOCKER_PWD=$2
echo $DOCKER_PWD | docker login -u $DOCKER_USER --password-stdin
echo "success"
