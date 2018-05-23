#!/bin/bash
VERSION="1.0.0"
NAMESPACE="mjlee1"
AUTHORS="MJLee"
BUILD_ARGS="--build-arg EXTRA_SEL_VERSION=2.0.4 \
 --build-arg CORE_SEL_VERSION_SHORT=3.11 \
 --build-arg np_proxy=localhost \
 "

#base
cd ./Base && docker build ${BUILD_ARGS} -t ${NAMESPACE}/base:${VERSION} .
docker tag ${NAMESPACE}/base:${VERSION} ${NAMESPACE}/base:latest

#hub
cd ../Hub && ./generate.sh ${VERSION} ${NAMESPACE} ${AUTHORS} &&
docker build ${BUILD_ARGS} -t ${NAMESPACE}/hub:${VERSION} . &&
docker tag ${NAMESPACE}/hub:${VERSION} ${NAMESPACE}/hub:latest

#nodebase
cd ../NodeBase && ./generate.sh ${VERSION} ${NAMESPACE} ${AUTHORS} &&
docker build ${BUILD_ARGS} -t ${NAMESPACE}/node-base:${VERSION} . &&
docker tag ${NAMESPACE}/node-base:${VERSION} ${NAMESPACE}/node-base:latest

#node-chrome
cd ../NodeChrome && ./generate.sh ${VERSION} ${NAMESPACE} ${AUTHORS} &&
docker build ${BUILD_ARGS} -t ${NAMESPACE}/node-chrome:${VERSION} . &&
docker tag ${NAMESPACE}/node-chrome:${VERSION} ${NAMESPACE}/node-chrome:latest

#node-firefox
cd ../NodeFirefox && ./generate.sh ${VERSION} ${NAMESPACE} ${AUTHORS} &&
docker build ${BUILD_ARGS} -t ${NAMESPACE}/node-firefox:${VERSION} . &&
docker tag ${NAMESPACE}/node-firefox:${VERSION} ${NAMESPACE}/node-firefox:latest
