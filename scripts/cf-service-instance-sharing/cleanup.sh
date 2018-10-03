#!/bin/bash -x

cf delete-service-broker -f $SERVICE_BROKER_NAME
cf disable-feature-flag service_instance_sharing
