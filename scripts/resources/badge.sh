#!/bin/bash

task() {
  printf "\e]1337;SetBadgeFormat=%s\a" "$(echo "$*" | base64)";
}

task $1

