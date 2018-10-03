#!/bin/bash

########################
# include the magic
########################
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../resources/demo-magic.sh

# hide the evidence
clear

pe "cf marketplace"

clean

pe "cf target -o $ORG -s $SERVICE_BROKER_SPACE"
BROKER_URL=http://$(cf app $SERVICE_BROKER_APP_NAME | awk '/routes:/{ print $2 }')
pe "cf create-service-broker $SERVICE_BROKER_NAME $SERVICE_BROKER_USERNAME $SERVICE_BROKER_PASSWORD ${BROKER_URL}"
pe "cf enable-service-access $SERVICE_NAME"

clean

pe "cf marketplace"

clean

pe "cf create-service $SERVICE_NAME $SERVICE_PLAN_NAME $SERVICE_INSTANCE_NAME"
pe "cf services"

clean

pe "cf create-service-key $SERVICE_INSTANCE_NAME $CREDENTIALS_NAME"
pe "cf service-key $SERVICE_INSTANCE_NAME $CREDENTIALS_NAME"

clean

pe "cf delete-service-key -f $SERVICE_INSTANCE_NAME $CREDENTIALS_NAME"
pe "cf delete-service -f $SERVICE_INSTANCE_NAME"
