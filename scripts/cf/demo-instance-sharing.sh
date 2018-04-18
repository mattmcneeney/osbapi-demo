#!/bin/bash

########################
# include the magic
########################
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../resources/demo-magic.sh

# put your stuff here
BROKER_URL=http://$(cf app $SERVICE_BROKER_APP_NAME | awk '/routes:/{ print $2 }')

# hide the evidence
clear

pe "cf feature-flags"
pe "cf enable-feature-flag service_instance_sharing"

clean

pe "cf create-space dev1"
pe "cf create-space dev2"
pe "cf target -s dev1"

clean

pe "cf create-service $SERVICE_NAME $SERVICE_PLAN_NAME $SERVICE_INSTANCE_NAME"
pe "cf services"

clean

pe "cf share-service $SERVICE_INSTANCE_NAME -s dev2"
pe "cf service $SERVICE_INSTANCE_NAME"

clean

pe "cf target -s dev2"
pe "cf services"
pe "cf service $SERVICE_INSTANCE_NAME"

clean

pe "cf target -s dev1"
pe "cf unshare-service -f $SERVICE_INSTANCE_NAME -s dev2"
pe "cf delete-service -f $SERVICE_INSTANCE_NAME"
