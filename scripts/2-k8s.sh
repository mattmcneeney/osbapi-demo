#!/bin/bash

########################
# include the magic
########################
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/resources/demo-magic.sh

# get the address of the controller
SVC_CAT_API=$(minikube service -n catalog catalog-catalog-apiserver --url | sed -n 1p)
echo $SVC_CAT_API

# create a new kubectl context
kubectl config set-cluster service-catalog --server=$SVC_CAT_API
kubectl config set-context service-catalog --cluster=service-catalog

# hide the evidence
clear

# put your stuff here
# show no broker has yet been registered
pe "kubectl --context=service-catalog get brokers,serviceclasses,instances,bindings"

clean

# register a broker
pe "less ${DIR}/resources/overview-broker.yaml"
pe "kubectl --context=service-catalog create -f ${DIR}/resources/overview-broker.yaml"

clean

# get the service class for the exposed services
pe "kubectl --context=service-catalog get serviceclasses"
pe "kubectl --context=service-catalog get serviceclass overview-broker-cf-summit -o yaml | less"

clean
# create a namespace for development
pe "kubectl create ns development"

# create a service instance
pe "less ${DIR}/resources/overview-instance.yaml"
pe "kubectl --context=service-catalog create -f ${DIR}/resources/overview-instance.yaml"

clean

# get the service instance
pe "kubectl --context=service-catalog -n development get instances"
pe "kubectl --context=service-catalog -n development get instances -o yaml | less"

clean

# create a service binding
pe "less ${DIR}/resources/overview-binding.yaml"
pe "kubectl --context=service-catalog create -f ${DIR}/resources/overview-binding.yaml"

clean

# get the service binding
pe "kubectl --context=service-catalog -n development get binding"
pe "kubectl --context=service-catalog -n development get binding  -o yaml | less"

clean

# get the secret
pe "kubectl get secrets -n development"
pe "kubectl get secrets -n development overview-credentials -o yaml | less"

clean

pe "kubectl --context=service-catalog -n development delete binding overview-binding"

# show secret has gone
pe "kubectl get secrets -n development"

# delete the instance
pe "kubectl --context=service-catalog -n development delete instance overview-instance"

