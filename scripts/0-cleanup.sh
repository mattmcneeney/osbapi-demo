#!/bin/bash -v

cf delete-service -f my-service
cf delete-service-broker -f overview-broker
cf delete -f overview-broker-cf-summit
cf delete -f extremely-basic-node-app
rm -r /tmp/demo

