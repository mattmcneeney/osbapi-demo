#!/bin/bash -e

# Check for required env vars
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$DIR/../resources/check-env-vars.sh ||
(
   echo "ERROR: Missing required environmental variables"
   exit 1
)

# Check the service broker app is deployed
cf apps | grep "$SERVICE_BROKER_APP_NAME" > /dev/null ||
(
   echo "ERROR: The $SERVICE_BROKER_APP_NAME app does not exist"
   exit 1
)
echo "The $SERVICE_BROKER_APP_NAME app is running"

# Check no service broker already exists
cf service-brokers | grep "$SERVICE_BROKER_NAME" > /dev/null &&
(
   echo "ERROR: The $SERVICE_BROKER_NAME service broker already exists"
   exit 1
)
echo "The $SERVICE_BROKER_NAME service broker doesn't exist"

# Check no service instnace already exists
cf services | grep "$SERVICE_INSTANCE_NAME" > /dev/null &&
(
   echo "ERROR: The $SERVICE_INSTANCE_NAME service instance already exists"
   exit 1
)
echo "No service instance conflicts detected"

# Check we are admin
cf target | grep -i "User:" | grep "admin" > /dev/null ||
(
   echo "ERROR: Not admin"
   exit 1
)
echo "You are admin :)"

echo "Ready!"

