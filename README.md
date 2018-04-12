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
# Checkout and deploy overview broker (service broker)
git clone git@github.com:mattmcneeney/overview-broker.git
cd overview-broker
cf push overview-broker-demo

# Update .envrc file with your desired environment variables

# Source the environment variables
source .envrc

# If you're setting up minikube or the service-catalog project for the first
# time, then this setup script may help you get up and running:
./scripts/k8s/setup.sh

# Check your environments are ready to go
./scripts/cf/check-env.sh
./scripts/k8s/check-env.sh
```

### Demo scripts
For best results, run the two demo scripts in side-by-side terminals! Simply hit
enter to print and then execute the next command in each script.
```
./scripts/cf/demo.sh
./scripts/k8s/demo.sh
```

After running the CF demo, you can also show how service instances can be shared
across spaces in CF:
```
./scripts/cf/demo-instance-sharing.sh
```

### Cleanup
```
./scripts/cf/cleanup.sh
./scripts/k8s/cleanup.sh
```
