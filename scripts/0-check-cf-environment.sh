#!/bin/bash -e

echo "Checking environment is clean and ready..."

cf apps | grep "overview-broker-demo" > /dev/null ||
(
   echo "WARNING: overview-broker-demo app does not exist" &&
   exit 1
)

cf apps | grep "extremely-basic-node-app" > /dev/null ||
(
   echo "WARNING: extremely-basic-node-app app does not exist" &&
   exit 1
)

cf service-brokers | grep "overview-broker" > /dev/null &&
(
   echo "WARNING: overview-broker service broker exists" &&
   exit 1
)

cf services | grep "my-service" > /dev/null &&
(
   echo "WARNING: my-service service exists" &&
   exit 1
)

cf target | grep -i "User:" | grep "admin" > /dev/null ||
(
   echo "WARNING: Not admin"
   exit 1
)

echo "Ready!"
