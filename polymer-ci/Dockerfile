#####################################################################
# Based on OpenJDK docker image
# Java 8 needed by web-component-tester (used by Polymer CLI)
# https://github.com/Polymer/web-component-tester#running-your-tests
#####################################################################
FROM openjdk:8-jre-slim

#####################################################################
# Install tools
#####################################################################
RUN apt-get update && apt-get install -y \
  git \
  xvfb \
  curl \
  gnupg \
&& rm -rf /var/lib/apt/lists/*

#####################################################################
# Install Node.js
# based on: https://github.com/timbru31/docker-java-node
# install node with script: https://github.com/nodesource/distributions
#####################################################################
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && apt-get install -y \
    nodejs \
&& rm -rf /var/lib/apt/lists/*

#####################################################################
# Install Yarn
#####################################################################
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo 'deb https://dl.yarnpkg.com/debian/ stable main' >> /etc/apt/sources.list.d/yarn.list \
&& apt-get update && apt-get install -y \
  yarn \
&& rm -rf /var/lib/apt/lists/*

#####################################################################
# Install Browsers
#####################################################################

# Chrome
RUN curl -sL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
&& echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list.d/google.list \
&& apt-get update && apt-get install -y \
  google-chrome-stable \
&& rm -rf /var/lib/apt/lists/*

# make Chrome run in no-sandbox mode to solve permission issues
RUN mv /usr/bin/google-chrome /usr/bin/google-chrome-orig \
    && echo '#!/bin/bash' > /usr/bin/google-chrome \
    && echo '/usr/bin/google-chrome-orig --no-sandbox --disable-setuid-sandbox --allow-sandbox-debugging "$@"' >> /usr/bin/google-chrome  \
    && chmod +x /usr/bin/google-chrome

# Firefox
ARG FIREFOX_VERSION=58.0.2
RUN wget --no-verbose -O /tmp/firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2 \
  && tar -C /opt -xjf /tmp/firefox.tar.bz2 \
  && rm /tmp/firefox.tar.bz2 \
  && ln -fs /opt/firefox/firefox /usr/bin/firefox


#####################################################################
# Installs
#####################################################################

RUN yarn global add bower
RUN yarn global add polymer-cli

# configure bower to allow to run with sudo
RUN echo '{ "allow_root": true }' > /root/.bowerrc
