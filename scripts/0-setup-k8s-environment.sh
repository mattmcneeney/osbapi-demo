#!/bin/bash -v

minikube start --extra-config=apiserver.Authorization.Mode=RBAC

helm init
helm repo add svc-cat https://svc-catalog-charts.storage.googleapis.com

kubectl create clusterrolebinding tiller-cluster-admin \
    --clusterrole=cluster-admin \
    --serviceaccount=kube-system:default

helm install svc-cat/catalog \
    --name catalog --namespace catalog --set insecure=true

SVC_CAT_API=$(minikube service -n catalog catalog-catalog-apiserver --url | sed -n 1p)
echo $SVC_CAT_API

kubectl config set-cluster service-catalog --server=$SVC_CAT_API
kubectl config set-context service-catalog --cluster=service-catalog

