#!/bin/bash

# Update package index and install Docker
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu
newgrp docker

# Install AWS CLI
sudo apt-get install -y awscli

# Configure AWS CLI
aws configure set aws_access_key_id "your_aws_access_key"
aws configure set aws_secret_access_key "your_aws_access_secret"
aws configure set region "ap-southeast-1"

# Authenticate Docker to ECR
#$(aws ecr get-login --no-include-email --region ap-southeast-1)
aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.ap-southeast-1.amazonaws.com

# Pull Docker image from ECR
docker pull aws_account_id.dkr.ecr.ap-southeast-1.amazonaws.com/pyapp:master

# Run Docker image
docker run -d -p 80:8080 --name pythoncontainer aws_account_id.dkr.ecr.ap-southeast-1.amazonaws.com/pyapp:master

