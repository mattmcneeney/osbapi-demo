#!/bin/bash

########################
# include the magic
########################
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/resources/demo-magic.sh

# create a namespace for development
kubectl create ns development

# get the address of the controller
SVC_CAT_API=$(minikube service -n catalog catalog-catalog-apiserver --url | sed -n 1p)
echo $SVC_CAT_API

# create a new kubectl context
kubectl config set-cluster service-catalog --server=$SVC_CAT_API
kubectl config set-context service-catalog --cluster=service-catalog

BROKER_URL=http://$(cf app $SERVICE_BROKER_APP_NAME | awk '/urls:/{ print $2 }')

# hide the evidence
clear

# put your stuff here

# show no broker has yet been registered
pe "kubectl --context=service-catalog get brokers,serviceclasses"

clean

# create the broker secret
cat >/tmp/k8s-resources/broker-secret.yaml <<EOL
apiVersion: v1
kind: Secret
metadata:
  name: broker-secret
type: Opaque
data:
  username: $(echo "$SERVICE_BROKER_USERNAME" | base64)
  password: $(echo "$SERVICE_BROKER_PASSWORD" | base64)
EOL
kubectl create -f /tmp/k8s-resources/broker-secret.yaml

# register a broker
cat >/tmp/k8s-resources/broker.yaml <<EOL
apiVersion: servicecatalog.k8s.io/v1alpha1
kind: Broker
metadata:
  name: $SERVICE_BROKER_NAME
spec:
  url: $BROKER_URL
  authInfo:
    basic:
      secretRef:
        namespace: development
        name: broker-secret
EOL
pe "less /tmp/k8s-resources/broker.yaml"
pe "kubectl --context=service-catalog create -f /tmp/k8s-resources/broker.yaml"

clean

# get the service class for the exposed services
pe "kubectl --context=service-catalog get serviceclasses"
pe "kubectl --context=service-catalog get serviceclass $SERVICE_NAME -o yaml | less"

clean

# create a service instance
cat >/tmp/k8s-resources/instance.yaml <<EOL
apiVersion: servicecatalog.k8s.io/v1alpha1
kind: Instance
metadata:
  name: $SERVICE_INSTANCE_NAME
  namespace: development
spec:
  serviceClassName: $SERVICE_NAME
  planName: $SERVICE_PLAN_NAME
EOL
pe "less /tmp/k8s-resources/instance.yaml"
pe "kubectl --context=service-catalog create -f /tmp/k8s-resources/instance.yaml"

# get the service instance
pe "kubectl --context=service-catalog -n development get instances -o yaml | less"

clean

# create a service binding
cat >/tmp/k8s-resources/binding.yaml <<EOL
apiVersion: servicecatalog.k8s.io/v1alpha1
kind: Binding
metadata:
  name: $SERVICE_BINDING_NAME
  namespace: development
spec:
  instanceRef:
    name: $SERVICE_INSTANCE_NAME
  secretName: $CREDENTIALS_NAME
EOL
pe "less /tmp/k8s-resources/binding.yaml"
pe "kubectl --context=service-catalog create -f /tmp/k8s-resources/binding.yaml"

# get the service binding
pe "kubectl --context=service-catalog -n development get binding  -o yaml | less"

# get the secret
pe "kubectl get secrets -n development"
pe "kubectl get secrets -n development $CREDENTIALS_NAME -o yaml | less"

clean

pe "kubectl --context=service-catalog -n development delete binding $SERVICE_BINDING_NAME"

# delete the instance
pe "kubectl --context=service-catalog -n development delete instance $SERVICE_INSTANCE_NAME"

