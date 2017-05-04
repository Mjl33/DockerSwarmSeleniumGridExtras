#!/bin/bash

#param $1 - the docker virtual machine we want to target, leave empty for VM=default

docker-machine env --no-proxy --shell cygwin $1 | egrep -v "#" > env

echo "Type - \"source ./env\""



