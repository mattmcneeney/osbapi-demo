#!/bin/bash -e

# Check for required env vars
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$DIR/../resources/check-env-vars.sh ||
(
   echo "ERROR: Missing required environmental variables"
   exit 1
)

# Check the org exists
cf orgs | grep "$ORG" > /dev/null ||
(
   echo "ERROR: Org '$ORG' does not exist"
   exit 1
)
echo "Org '$ORG' exists"

# Check the service broker app is deployed
cf target -o $ORG -s $SERVICE_BROKER_SPACE > /dev/null
cf apps | grep "$SERVICE_BROKER_APP_NAME" > /dev/null ||
(
   echo "ERROR: The '$SERVICE_BROKER_APP_NAME' app does not exist in org '$ORG', space '$SERVICE_BROKER_SPACE'"
   exit 1
)
echo "The '$SERVICE_BROKER_APP_NAME' app is running in org '$ORG', space '$SERVICE_BROKER_SPACE'"

# Check no service broker already exists
cf service-brokers | grep "$SERVICE_BROKER_NAME" > /dev/null &&
(
   echo "ERROR: The '$SERVICE_BROKER_NAME' service broker already exists"
   exit 1
)
echo "The '$SERVICE_BROKER_NAME' service broker doesn't exist"

# Check we are admin
cf target | grep -i "User:" | grep "admin" > /dev/null ||
(
   echo "ERROR: You are not a CF admin"
   exit 1
)
echo "You are a CF admin"

# Check the source space exists
cf target -o $ORG  > /dev/null
cf spaces | grep "$SOURCE_SPACE" > /dev/null ||
(
   echo "ERROR: Space '$SOURCE_SPACE' in org '$ORG' does not exist"
   exit 1
)
echo "Space '$SOURCE_SPACE' in org '$ORG' exists"

# Check the target space exists
cf target -o $ORG  > /dev/null
cf spaces | grep "$TARGET_SPACE" > /dev/null ||
(
   echo "ERROR: Space '$TARGET_SPACE' in org '$ORG' does not exist"
   exit 1
)
echo "Space '$TARGET_SPACE' in org '$ORG' exists"

# Check the source app exists
cf target -o $ORG -s $SOURCE_SPACE  > /dev/null
cf apps | grep "$SOURCE_APP" > /dev/null ||
(
   echo "ERROR: Missing app '$SOURCE_APP' in org '$ORG', space '$SOURCE_SPACE'"
   exit 1
)
echo "App '$SOURCE_APP' exists in org '$ORG', space '$SOURCE_SPACE'"

# Check the target app exists
cf target -o $ORG -s $TARGET_SPACE  > /dev/null
cf apps | grep "$TARGET_APP" > /dev/null ||
(
   echo "ERROR: Missing app '$TARGET_APP' in org '$ORG', space '$TARGET_SPACE'"
   exit 1
)
echo "App '$TARGET_APP' exists in org '$ORG', space '$TARGET_SPACE'"

# Check no service instances exist in the source space

echo "Ready!"
