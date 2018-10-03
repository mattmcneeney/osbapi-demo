# Open Service Broker API Demos

Any service broker can be used for the demos contained in this repo, but these
instructions detail deploying a dummy broker
([overview broker](https://github.com/mattmcneeney/overview-broker))
as a Cloud Foundry application. This broker doesn't provision an underlying
service and can be set to behave synchronously for a faster demo, and provides a
visual representation via the web dashboard all service instances and bindings
that have been created, alongside the platform they were created from.

**Note: All scripts should be called from the root of the repository!**

### Preparation
```
# Checkout and deploy overview broker (service broker)
git clone git@github.com:mattmcneeney/overview-broker.git
cd overview-broker
cf push overview-broker

# Update .envrc file with your desired environment variables

# Source the environment variables
source .envrc

# If you're setting up minikube or the service-catalog project for the first
# time, then this setup script may help you get up and running:
./scripts/k8s/setup.sh
```

### Demo scripts

#### How OSBAPI is supported by both CF and k8s

This demo shows how you can create a service instance and service binding
to the same service broker from Cloud Foundry and Kubernetes environments.

For best results, run the two demo scripts in side-by-side terminals! Simply hit
enter to print and then execute the next command in each script.
```
# Check your environments are ready to go
./scripts/cf/check-env.sh
./scripts/k8s/check-env.sh

# Start the demo scripts
./scripts/cf/demo.sh
./scripts/k8s/demo.sh

# Cleanup
./scripts/cf/cleanup.sh
./scripts/k8s/cleanup.sh
```

#### Service instance sharing in CF
```
# Check your environments are ready to go
./scripts/cf/check-env.sh

# Start the demo scripts
./scripts/cf-service-instance-sharing/demo.sh

# Cleanup
./scripts/cf-service-instance-sharing/demo.sh
```
