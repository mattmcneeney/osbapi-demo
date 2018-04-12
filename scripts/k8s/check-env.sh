#!/bin/bash -e

# Check for required env vars
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$DIR/../resources/check-env-vars.sh ||
(
   echo "ERROR: Missing required environmental variables"
   exit 1
)

# Check that minikube is running
minikube status | grep "minikube: Running" > /dev/null ||
(
   echo "ERROR: minikube is not running"
   exit 1
)
echo "minikube is running"

# Check that the catalog-apiserver is running
kubectl --all-namespaces=true get pods | grep catalog-apiserver | grep Running > /dev/null ||
(
   echo "ERROR: catalog-apiserver is not running"
   exit 1
)
echo "catalog-apiserver is running"

# Check that the catalog-controller is running
kubectl --all-namespaces=true get pods | grep catalog-controller | grep Running > /dev/null ||
(
   echo "ERROR: catalog-controller is not running"
   exit 1
)
echo "catalog-controller is running"

# Setup temp resources directory
rm -rf /tmp/k8s-resources
mkdir -p /tmp/k8s-resources

echo "Ready!"
