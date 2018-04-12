#!/bin/bash -ex

minikube start --extra-config=apiserver.Authorization.Mode=RBAC

helm init
helm repo add svc-cat https://svc-catalog-charts.storage.googleapis.com

kubectl create clusterrolebinding tiller-cluster-admin \
    --clusterrole=cluster-admin \
    --serviceaccount=kube-system:default

# The helm install will fail if we run this immediately. Give tiller
# some time to get ready...
sleep 60
helm install svc-cat/catalog \
    --name catalog --namespace catalog --set insecure=true
