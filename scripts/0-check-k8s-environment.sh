#!/bin/bash -e

echo "Checking k8s environment is clean and ready..."

SVC_CAT_API=$(minikube service -n catalog catalog-catalog-apiserver --url | sed -n 1p)
echo $SVC_CAT_API

#CREATE a new kubectl context
kubectl config set-cluster service-catalog --server=$SVC_CAT_API
kubectl config set-context service-catalog --cluster=service-catalog

echo "Ready!"
