#!/bin/bash

source /opt/bin/functions.sh

#export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi

SERVERNUM=$(get_server_num)

#rm -f /tmp/.X*lock

#xvfb-run -n $SERVERNUM --server-args="-screen 0 $GEOMETRY -ac +extension RANDR" \
java -Dhttp.useProxy=true -Dhttp.proxyHost=10.129.49.21 -Dhttp.proxyPort=8080 \
	-Dhttps.useProxy=true -Dhttps.proxyHost=10.129.49.21 -Dhttps.proxyPort=8080 \
	-Dhttp.nonProxyHosts="10.210.69.*|127.0.0.1|localhost" \
  	${JAVA_OPTS} -jar /opt/selenium/selenium-server-standalone.jar \
	${SE_OPTS} &
NODE_PID=$!

trap shutdown SIGTERM SIGINT
wait $NODE_PID
