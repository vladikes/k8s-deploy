#!/bin/sh

kubectl apply -f flask-app-deployment.yml
kubectl apply -f flask-app-service.yml
