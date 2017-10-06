#!/bin/bash

########################
# include the magic
########################
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/resources/demo-magic.sh

# secret setup
mkdir -p /tmp/demo/overview-broker
cp -r ~/workspace/apps/overview-broker/* /tmp/demo/overview-broker/
cd /tmp/demo

# hide the evidence
clear

# put your stuff here
p "git clone git@github.com:mattmcneeney/overview-broker.git"
pe "cd overview-broker"
pe "ls"
pe "cf push overview-broker-cf-summit"

