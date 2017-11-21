#!/bin/bash -x

kubectl delete clusterservicebroker $SERVICE_BROKER_NAME
kubectl -n development delete secret broker-secret
kubectl delete ns development

