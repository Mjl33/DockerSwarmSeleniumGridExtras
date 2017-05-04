docker build -t hub \
	--build-arg http_proxy=http://$HTTP_PROXY:$PROXY_PORT \
	--build-arg https_proxy=http://$HTTP_PROXY:$PROXY_PORT \
	--build-arg no_proxy="localhost, 192.168.99.1" \
	.

