#!/bin/bash
set -e

echo "Building Docker image..."
docker build -t devops-challenge:local .

echo "Applying Terraform..."
cd terraform
terraform init -input=false
terraform apply -auto-approve
cd ..

echo "Installing Helm chart..."
helm upgrade --install devops-challenge ./helm --namespace devops-challenge --create-namespace
