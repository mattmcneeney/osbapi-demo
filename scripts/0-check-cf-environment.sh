#!/bin/bash -e

# Check the service broker app is deployed
cf apps | grep "$SERVICE_BROKER_APP_NAME" > /dev/null ||
(
   echo "ERROR: The $SERVICE_BROKER_APP_NAME app does not exist" &&
   exit 1
)

# Check no service broker already exists
cf service-brokers | grep "$SERVICE_BROKER_NAME" > /dev/null &&
(
   echo "ERROR: The $SERVICE_BROKER_NAME service broker already exists" &&
   exit 1
)

# Check no service instnace already exists
cf services | grep "my-service" > /dev/null &&
(
   echo "ERROR: my-service service exists" &&
   exit 1
)

# Check we are admin
cf target | grep -i "User:" | grep "admin" > /dev/null ||
(
   echo "ERROR: Not admin"
   exit 1
)

echo "Ready!"

