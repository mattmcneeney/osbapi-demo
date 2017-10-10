#!/bin/bash

kubectl --context=service-catalog delete broker overview-broker
kubectl delete ns development
