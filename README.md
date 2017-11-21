# Open Service Broker API Demo

### Overview
This demo shows how you can create a service instance and service binding
to the same service broker from Cloud Foundry and Kubernetes environments.

Any service broker can be used, but these instructions detail deploying a
dummy broker ([overview broker](https://github.com/mattmcneeney/overview-broker))
as a Cloud Foundry application. This broker doesn't provision an underlying
service, but provides a visual representation via a browser dashboard of any
service instances or bindings that have been created alongside the platform
they were created from.

**All scripts should be called from the root of the repository!**

### Preparation
```
# Checkout and deploy overview broker (the service broker)
git clone git@github.com:mattmcneeney/overview-broker.git
cd overview-broker
cf push overview-broker-demo

# Update the Kubernetes broker resource YAML with the URL
# of the service broker you have deployed
sed -i -e 's/\$URL/YOUR-BROKER-URL/g' ./scripts/resources/overview-broker.yaml

# Set your environmental variables, for example:
SERVICE_BROKER_APP_NAME=overview-broker-demo
SERVICE_BROKER_NAME=overview-broker-demo
SERVICE_INSTANCE_NAME=my-service
SERVICE_BINDING_NAME=my-binding
CREDENTIALS_NAME=my-secret

# Check your environment is ready to go
./scripts/0-check-environment.sh
./scripts/0-check-cf-environment.sh
./scripts/0-check-k8s-environment.sh
```

### Demo scripts
For best results, run these in side-by-side terminals! Simply hit enter to
print and then execute the next command in each script.
```
./scripts/1-cf.sh
./scripts/2-k8s.sh
```

### Cleanup
```
./scripts/0-cleanup-cf.sh
./scripts/0-cleanup-k8s.sh
```
