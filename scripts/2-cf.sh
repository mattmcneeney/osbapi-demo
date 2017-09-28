#!/bin/bash

########################
# include the magic
########################
. scripts/resources/demo-magic.sh

# secret setup
mkdir -p demo/extremely-basic-node-app
cp -r ~/workspace/apps/extremely-basic-node-app/* demo/extremely-basic-node-app/
cd demo

# hide the evidence
clear

# put your stuff here
pe "BROKER_URL=http://$(cf app overview-broker | awk '/urls:/{ print $2 }')"
pe "cf create-service-broker overview-broker admin password ${BROKER_URL}"
pe "cf enable-service-access overview-broker"
pe "cf marketplace"
pe "cf create-service overview-broker simple my-service"
pe "cf services"
pe "open '${BROKER_URL}'"
p "git clone git@github.com:mattmcneeney/extremely-basic-node-app.git"
pe "cd extremely-basic-node-app"
pe "cf push"
pe "cf bind-service extremely-basic-node-app my-service"
pe "cf restart extremely-basic-node-app"
pe "cf env extremely-basic-node-app"
pe "open '${BROKER_URL}'"
pe "cf unbind-service extremely-basic-node-app my-service"
pe "cf delete-service -f my-service"
pe "open '${BROKER_URL}'"
