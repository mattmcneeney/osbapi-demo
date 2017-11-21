#!/bin/bash -e

declare -a env_vars=("SERVICE_BROKER_APP_NAME" "SERVICE_BROKER_NAME" "SERVICE_BROKER_USERNAME" "SERVICE_BROKER_PASSWORD" "SERVICE_NAME" "SERVICE_PLAN_NAME" "SERVICE_INSTANCE_NAME" "SERVICE_BINDING_NAME" "CREDENTIALS_NAME")

for v in "${env_vars[@]}"
do
   if [ -z ${!v} ]; then
      echo "ERROR: Missing environmental variable $v"
   else
      echo "$v: ${!v}"
   fi
done

