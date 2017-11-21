#!/bin/bash -e

declare -a env_vars=("SERVICE_BROKER_APP_NAME SERVICE_BROKER_NAME SERVICE_INSTANCE_NAME SERVICE_BINDING_NAME CREDENTIALS_NAME")

for v in "${env_vars[@]}"
do
   if [ -z "$${v}" ]; then
      echo "ERROR: Missing environmental variable $v"
      exit 1
   fi
done

