#!/bin/bash -e

echo "Checking environment is clean and ready..."

cf apps | grep "spring-broker-demo" > /dev/null ||
(
   echo "WARNING: spring-broker-demo app does not exist" &&
   exit 1
)

cf service-brokers | grep "spring-broker" > /dev/null &&
(
   echo "WARNING: spring-broker service broker exists" &&
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
