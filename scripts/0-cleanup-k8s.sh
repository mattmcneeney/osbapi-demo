#!/bin/bash -v

kubectl --context=service-catalog delete broker $SERVICE_BROKER_NAME
kubectl delete ns development

