#!/bin/bash
echo "Forwarding port..."
kubectl port-forward svc/secure-api 8080:80 -n devops-challenge &
sleep 3
echo "Container UID:"
kubectl exec -n devops-challenge deploy/secure-api -- id
echo "Ports:"
kubectl exec -n devops-challenge deploy/secure-api -- netstat -tulpn
echo "Testing API:"
curl http://localhost:8080
