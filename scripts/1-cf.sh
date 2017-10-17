#!/bin/bash

########################
# include the magic
########################
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/resources/demo-magic.sh

# hide the evidence
clear

# put your stuff here
BROKER_URL=http://$(cf app overview-broker-demo | awk '/urls:/{ print $2 }')
pe "cf apps"

clean

pe "cf marketplace"

clean

pe "cf create-service-broker overview-broker-demo admin password ${BROKER_URL}"
pe "cf enable-service-access overview-broker-demo"

clean

pe "cf marketplace"

clean

pe "cf create-service overview-broker-demo simple my-service"
pe "cf services"

clean

pe "cf create-service-key my-service my-key"
pe "cf service-key my-service my-key"

clean

pe "cf delete-service-key -f my-service my-key"
pe "cf delete-service -f my-service"
