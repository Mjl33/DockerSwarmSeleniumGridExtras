FROM phusion/baseimage:0.10.1
LABEL authors="MJLee"

#================================================
# Customize sources for apt-get
#================================================
RUN  echo "deb http://archive.ubuntu.com/ubuntu xenial main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu xenial-updates main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu xenial-security main universe\n" >> /etc/apt/sources.list

# No interactive frontend during docker build
ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

#========================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#========================
RUN apt-get -qqy update \
  && apt-get -qqy --no-install-recommends install \
    bzip2 \
    ca-certificates \
    openjdk-8-jre-headless \
    tzdata \
    sudo \
    unzip \
    wget \
    lsof \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

#===================
# Timezone settings
# Possible alternative: https://github.com/docker/docker/issues/3359#issuecomment-32150214
#===================
ENV TZ "UTC"
RUN echo "${TZ}" > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

#========================================
# Add normal user with passwordless sudo
#========================================
RUN useradd seluser \
         --shell /bin/bash  \
         --create-home \
  && usermod -a -G sudo seluser \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'seluser:secret' | chpasswd

#===================================================
# Run the following commands as non-privileged user
#===================================================
USER seluser

#=======================
# Webdrivers for:
# - Core Selenium server
# - Selenium grid extras
#=======================
ARG CORE_SEL_VERSION_SHORT=3.11
ARG CORE_SEL_VERSION_FULL=${CORE_SEL_VERSION_SHORT}.0
ENV CORE_SEL_VERSION_FULL=${CORE_SEL_VERSION_FULL}
ARG EXTRA_SEL_VERSION=2.0.2

#==========
# Selenium extra
#==========
RUN  sudo mkdir -p /opt/selenium \
  && sudo chown seluser:seluser /opt/selenium \
  && wget --no-verbose https://github.com/groupon/Selenium-Grid-Extras/releases/download/v${EXTRA_SEL_VERSION}/SeleniumGridExtras-${EXTRA_SEL_VERSION}-SNAPSHOT-jar-with-dependencies.jar \
    -O /opt/selenium/selenium-server-standalone.jar -e use_proxy=yes

#==========
#Core selenium
#==========
RUN sudo mkdir -p /tmp/webdriver \
  && sudo chown seluser:seluser /tmp/webdriver \
  && wget --no-verbose https://selenium-release.storage.googleapis.com/$CORE_SEL_VERSION_SHORT/selenium-server-standalone-${CORE_SEL_VERSION_FULL}.jar \
    -O /tmp/webdriver/${CORE_SEL_VERSION_FULL}.jar -e use_proxy=yes

#========================
# Debug tools - install only if --build-arg DEBUG=true
#========================
USER root
ARG DEBUG=false
RUN if [ "${DEBUG}" = "true" ]; then \
    apt-get -qqy update \
      && apt-get -qqy --no-install-recommends install \
          coreutils \
          iputils-ping \
          net-tools \
      && rm -rf /var/lib/apt/lists/* /var/cache/apt/*; \
    fi

WORKDIR "/opt/selenium"
