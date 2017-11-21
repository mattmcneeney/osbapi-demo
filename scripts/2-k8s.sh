#!/bin/bash

########################
# include the magic
########################
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/resources/demo-magic.sh

# hide the evidence
clear

# create a namespace
kubectl create ns $NAMESPACE

BROKER_URL=http://$(cf app $SERVICE_BROKER_APP_NAME | awk '/urls:/{ print $2 }')

# create the broker secret
cat >/tmp/k8s-resources/broker-secret.yaml <<EOL
apiVersion: v1
kind: Secret
metadata:
  name: broker-secret
  namespace: $NAMESPACE
type: Opaque
data:
  username: $(echo -n "$SERVICE_BROKER_USERNAME" | base64)
  password: $(echo -n "$SERVICE_BROKER_PASSWORD" | base64)
EOL
kubectl create -f /tmp/k8s-resources/broker-secret.yaml

# put your stuff here

# show no broker has yet been registered
pe "kubectl get clusterservicebrokers,clusterserviceclasses"

clean

# register a broker
cat >/tmp/k8s-resources/broker.yaml <<EOL
apiVersion: servicecatalog.k8s.io/v1beta1
kind: ClusterServiceBroker
metadata:
  name: $SERVICE_BROKER_NAME
spec:
  url: $BROKER_URL
  authInfo:
    basic:
      secretRef:
        namespace: $NAMESPACE
        name: broker-secret
EOL
pe "less /tmp/k8s-resources/broker.yaml"
pe "kubectl create -f /tmp/k8s-resources/broker.yaml"

clean

# get the service class for the exposed services
pe "kubectl get clusterserviceclasses"
pe "kubectl get clusterserviceclasses -o yaml | less"

clean

# create a service instance
cat >/tmp/k8s-resources/instance.yaml <<EOL
apiVersion: servicecatalog.k8s.io/v1beta1
kind: ServiceInstance
metadata:
  name: $SERVICE_INSTANCE_NAME
  namespace: $NAMESPACE
spec:
  clusterServiceClassExternalName: $SERVICE_NAME
  clusterServicePlanExternalName: $SERVICE_PLAN_NAME
EOL
pe "less /tmp/k8s-resources/instance.yaml"
pe "kubectl create -f /tmp/k8s-resources/instance.yaml"

# get the service instance
pe "kubectl -n $NAMESPACE get serviceinstances -o yaml | less"

clean

# create a service binding
cat >/tmp/k8s-resources/binding.yaml <<EOL
apiVersion: servicecatalog.k8s.io/v1beta1
kind: ServiceBinding
metadata:
  name: $SERVICE_BINDING_NAME
  namespace: $NAMESPACE
spec:
  instanceRef:
    name: $SERVICE_INSTANCE_NAME
  secretName: $CREDENTIALS_NAME
EOL
pe "less /tmp/k8s-resources/binding.yaml"
pe "kubectl create -f /tmp/k8s-resources/binding.yaml"

# get the service binding
pe "kubectl -n $NAMESPACE get servicebindings  -o yaml | less"

# get the secret
pe "kubectl get secrets -n $NAMESPACE"
pe "kubectl get secrets -n $NAMESPACE $CREDENTIALS_NAME -o yaml | less"

clean

pe "kubectl -n $NAMESPACE delete servicebinding $SERVICE_BINDING_NAME"

# delete the instance
pe "kubectl -n $NAMESPACE delete serviceinstance $SERVICE_INSTANCE_NAME"

