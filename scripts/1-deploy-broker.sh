#!/bin/bash

########################
# include the magic
########################
. scripts/resources/demo-magic.sh

# secret setup
mkdir -p demo/overview-broker
cp -r ~/workspace/apps/overview-broker/* demo/overview-broker/
cd demo

# hide the evidence
clear

# put your stuff here
p "git clone git@github.com:mattmcneeney/overview-broker.git"
pe "cd overview-broker"
pe "ls"
pe "cf push overview-broker-cf-summit"
