#!/bin/bash -x

cf delete-service-broker -f $SERVICE_BROKER_NAME
cf disable-feature-flag service_instance_sharing
cf delete-space -f dev1
cf delete-space -f dev2
