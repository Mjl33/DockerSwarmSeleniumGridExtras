#!/bin/bash

docker-machine create -d virtualbox \
	--engine-env HTTP_PROXY=http://$HTTP_PROXY:$PROXY_PORT \
	--engine-env HTTPS_PROXY=http://$HTTP_PROXY:$PROXY_PORT \
	--engine-env NO_PROXY="localhost, 127.0.0.1" \
	--virtualbox-cpu-count "4" \
	--virtualbox-memory "8192" \
	$1
