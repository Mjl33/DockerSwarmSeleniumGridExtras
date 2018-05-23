#!/bin/bash

ROOT=/opt/selenium
CONF=$ROOT/config.json
CONF_EXTRA=$ROOT/selenium_grid_extras_config.json

/opt/bin/generate_config >$CONF
/opt/bin/generate_extras_config >$CONF_EXTRA

echo "starting selenium hub with configuration:"
cat $CONF

if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi

function shutdown {
    echo "shutting down hub.."
    kill -s SIGTERM $NODE_PID
    wait $NODE_PID
    echo "shutdown complete"
}

java ${JAVA_OPTS} -jar /opt/selenium/selenium-server-standalone.jar \
  -role hub \
  -hubConfig $CONF \
  ${SE_OPTS} &
NODE_PID=$!

trap shutdown SIGTERM SIGINT
wait $NODE_PID
