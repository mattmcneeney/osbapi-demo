#!/bin/bash

########################
# include the magic
########################
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../resources/demo-magic.sh

# hide the evidence
clear

pe "cf target -o $ORG -s $SERVICE_BROKER_SPACE"
BROKER_URL=http://$(cf app $SERVICE_BROKER_APP_NAME | awk '/routes:/{ print $2 }')
pe "cf create-service-broker $SERVICE_BROKER_NAME $SERVICE_BROKER_USERNAME $SERVICE_BROKER_PASSWORD ${BROKER_URL}"
pe "cf enable-service-access $SERVICE_NAME"

clean

pe "cf marketplace"

clean

pe "cf feature-flags"
pe "cf enable-feature-flag service_instance_sharing"

clean

pe "cf target -o $ORG -s $SOURCE_SPACE"

clean

pe "cf create-service $SERVICE_NAME $SERVICE_PLAN_NAME $SERVICE_INSTANCE_NAME"
pe "cf services"

clean

pe "cf bind-service $SOURCE_APP $SERVICE_INSTANCE_NAME"
pe "cf restart $SOURCE_APP"
pe "open http://$(cf app $SOURCE_APP | awk '/routes:/{ print $2 }')"

clean

pe "cf share-service $SERVICE_INSTANCE_NAME -o $ORG -s $TARGET_SPACE"
pe "cf service $SERVICE_INSTANCE_NAME"

clean

pe "cf target -o $ORG -s $TARGET_SPACE"
pe "cf services"
pe "cf service $SERVICE_INSTANCE_NAME"

clean

pe "cf bind-service $TARGET_APP $SERVICE_INSTANCE_NAME"
pe "cf restart $TARGET_APP"
pe "open http://$(cf app $TARGET_APP | awk '/routes:/{ print $2 }')"

clean

pe "cf target -o $ORG -s $SOURCE_SPACE"
pe "cf service $SERVICE_INSTANCE_NAME"

clean

pe "cf unshare-service -f $SERVICE_INSTANCE_NAME -o $ORG -s $TARGET_SPACE"
pe "cf unbind-service $SOURCE_APP $SERVICE_INSTANCE_NAME"
pe "cf delete-service -f $SERVICE_INSTANCE_NAME"

