#!/bin/bash -v

cf delete-service-broker -f overview-broker
cf delete -f overview-broker
cf delete -f extremely-basic-node-app
