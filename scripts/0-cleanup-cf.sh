#!/bin/bash -v

cf delete-service -f my-service
cf delete-service-broker -f overview-broker-cf-summit

