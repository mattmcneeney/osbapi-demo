#!/bin/bash -ex

echo "Checking k8s environment is clean and ready..."

#TODO check if minikube is running
cd $HOME/workspace/service-catalog
minikube start

#TODO check if helm & service catalog is setup
#DEPLOY the service-catalog
#Use helm to setup the components
helm init
sleep 30
helm install charts/catalog --name catalog --namespace catalog
sleep 30

#FIND service catalog api endpoint 
SVC_CAT_API=$(minikube service -n catalog catalog-catalog-apiserver --url | sed -n 1p)
echo $SVC_CAT_API

#CREATE a new kubectl context
kubectl config set-cluster service-catalog --server=$SVC_CAT_API
kubectl config set-context service-catalog --cluster=service-catalog

echo "Ready!"
