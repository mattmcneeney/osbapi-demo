#!/bin/bash -e

echo "Checking environment is clean and ready..."

cf apps | grep "overview-broker-cf-summit" > /dev/null &&
(
   echo "WARNING: overview-broker-cf-summit app exists" &&
   exit 1
)

cf apps | grep "extremely-basic-node-app" > /dev/null &&
(
   echo "WARNING: extremely-basic-node-app app exists" &&
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

if [ ! -d ~/workspace/apps/overview-broker ]; then
   echo "WARNING: ~/workspace/apps/overview-broker not found"
   exit 1
fi

if [ ! -d ~/workspace/apps/extremely-basic-node-app ]; then
   echo "WARNING: ~/workspace/apps/extremely-basic-node-appp not found"
   exit 1
fi

echo "Ready!"
