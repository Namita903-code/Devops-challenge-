#!/bin/bash
set -e
echo "Building Docker image..."
docker build -t secure-api .
echo "Applying Terraform..."
terraform -chdir=terraform init
terraform -chdir=terraform apply -auto-approve
echo "Deploying Helm..."
helm upgrade --install secure-api helm/ -n devops-challenge
