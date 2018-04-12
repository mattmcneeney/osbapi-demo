#!/bin/bash -x

kubectl delete clusterservicebroker $SERVICE_BROKER_NAME
kubectl -n $NAMESPACE delete secret broker-secret
kubectl delete namespace $NAMESPACE
