# Selenium Grid Extras

This is an extension of (https://github.com/SeleniumHQ/docker-selenium) and (https://github.com/groupon/Selenium-Grid-Extras).

## Dockerfile

[`mjlee1` Dockerfiles](https://github.com/Mjl33/DockerSeleniumGrid)

## How to build this image
First, edit and run _make.sh_ with corresponding build arguments
```bash
VERSION="1.0.0"
NAMESPACE="mjlee1-sel"
AUTHORS="MJLee"
BUILD_ARGS="--build-arg EXTRA_SEL_VERSION=2.0.4 \
 --build-arg CORE_SEL_VERSION_SHORT=3.12 \
 --build-arg http_proxy=http://my-proxy:8080 \
 --build-arg https_proxy=http://my-proxy:8080 \
 --build-arg np_proxy=localhost \
 "
```
Editable build-time arguments for BUILD_ARGS
```bash
CORE_SEL_VERSION_SHORT=3.12             //selenium core version
EXTRA_SEL_VERSION=2.0.4                 //selenium grid extras version
CHROME_VERSION="google-chrome-stable"   //chrome version
CHROME_DRIVER_VERSION="latest"          //chromedriver version
FIREFOX_VERSION=latest                  //firefox version
GECKODRIVER_VERSION=latest              //geckodriver version
```


## Deploying on docker swarm
Create docker swarm
```bash
docker swarm init --advertise-addr <nodeIP>
```
Deploy service
```bash
docker stack deploy --compose-file docker-compose.yml grid
```
Scaling grid via swarm
```bash
docker service scale grid_node-chrome=10
docker service scale grid_node-firefox=10
```

## Changing run-time  variables
Run time environment variables can be changed in `docker-compose.yml` under the `environment` section.
Example:
```dockerfile
  node-chrome:
    labels:
      name: selenium.node.chrome
    image: mjlee1/node-chrome:1.0.0
    deploy:
      replicas: 2
    volumes:
      - /dev/shm:/dev/shm
    depends_on:
      - grid-hub
    environment:
      TZ: "Europe/London"
      LC_ALL: "C.UTF-8"
      no_proxy: "10.200.169.16,10.200.169.17,10.200.169.18,10.200.169.19,10.200.169.20,10.200.169.21,10.200.169.22,10.200.169.65"
      GRID_MAX_SESSION: 1
      NODE_DOWN_POLLING_LIMIT: 0
      HUB_HOST: "selenium-hub"
      HUB_PORT_PARAM: 4444
    networks:
      - grid
```

Editable run-time environment variables 
```bash
//Grid hub variables
GRID_MAX_SESSION 5
# In milliseconds, maps to "newSessionWaitTimeout"
GRID_NEW_SESSION_WAIT_TIMEOUT -1
# As a boolean, maps to "throwOnCapabilityNotPresent"
GRID_THROW_ON_CAPABILITY_NOT_PRESENT true
# As an integer
GRID_JETTY_MAX_THREADS -1
# In milliseconds, maps to "cleanUpCycle"
GRID_CLEAN_UP_CYCLE 5000
# In seconds, maps to "browserTimeout"
GRID_BROWSER_TIMEOUT 0
# In seconds, maps to "timeout"
GRID_TIMEOUT 30
# Debug
GRID_DEBUG false
# As integer, maps to "port"
GRID_HUB_PORT 4444

//xvfb variables
SCREEN_WIDTH 1360
SCREEN_HEIGHT 1020
SCREEN_DEPTH 24
DISPLAY :99.0

//Grid node variables
NODE_MAX_INSTANCES 1
# As integer, maps to "maxSession"
NODE_MAX_SESSION 1
# As integer, maps to "port"
NODE_PORT 5555
# In milliseconds, maps to "registerCycle"
NODE_REGISTER_CYCLE 5000
# In milliseconds, maps to "nodePolling"
NODE_POLLING 5000
# In milliseconds, maps to "unregisterIfStillDownAfter"
NODE_UNREGISTER_IF_STILL_DOWN_AFTER 60000
# As integer, maps to "downPollingLimit"
NODE_DOWN_POLLING_LIMIT 2
# As string, maps to "applicationName"
NODE_APPLICATION_NAME ""

//Grid extra variables
#As string, maps to "videos_to_keep"
VIDEOS_TO_KEEP "40"
```

## What is Selenium?
_Selenium automates browsers._ That's it! What you do with that power is entirely up to you. Primarily, it is for automating web applications for testing purposes, but is certainly not limited to just that. Boring web-based administration tasks can (and should!) also be automated as well.

Selenium has the support of some of the largest browser vendors who have taken (or are taking) steps to make Selenium a native part of their browser. It is also the core technology in countless other browser automation tools, APIs and frameworks.

See the Selenium [site](http://docs.seleniumhq.org/) for documation on usage within your test code.

### Issues

If you have any problems with or questions about this image, please contact us through a [Github issue](https://github.com/SeleniumHQ/docker-selenium/issues). If you have any problems with or questions about Selenium, please contact us through Selenium's [Bug Tracker](https://github.com/SeleniumHQ/selenium/issues).
