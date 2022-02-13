FROM node:16

#####################################################################
# Install Xvfb and basic dependencies
#####################################################################
RUN apt-get update -y && \
    apt-get install -y tzdata && \
    apt-get install -y g++ gcc make python2.7 libx11-dev libx11-xcb1 libxtst6 libnss3-dev libasound2 libxkbfile-dev && \
    apt-get install -y libxkbfile-dev pkg-config libsecret-1-dev libxss1 dbus xvfb libgtk-3-0 libgbm1 x11-utils libxtst-dev libpng++-dev

#####################################################################
# Install yarn
#####################################################################
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

#####################################################################
# Running Xvfb in bacground
#####################################################################
COPY bootstrap.sh /
RUN chmod a+x /bootstrap.sh
ENTRYPOINT [ "/bootstrap.sh" ]
