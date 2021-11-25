FROM adoptopenjdk/openjdk11:alpine

ENV SCALA_VERSION=2.13.7
ENV SCALA_HOME=/usr/local/scala 
ENV SBT_VERSION=1.5.5
ENV SBT_HOME=/usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin
ENV PATH ${PATH}:${SCALA_HOME}/bin
ENV PATH ${PATH}:${JAVA_HOME}/bin

WORKDIR /scala

# Install dependencies
RUN apk add --no-cache --virtual=.build-dependencies wget unzip && \
    apk add --update bash git openssh-client ca-certificates  && \
    eval $(ssh-agent -s) 

# Install Scala & SBT
RUN mkdir -p ${SCALA_HOME} ${SBT_HOME}
RUN wget -qO - --no-check-certificate "http://scala-lang.org/files/archive/scala-${SCALA_VERSION}.tgz" | tar xz -C $SCALA_HOME --strip-components=1
RUN wget -qO - --no-check-certificate https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz  | tar xz -C $SBT_HOME --strip-components=1
RUN apk del .build-dependencies
RUN sbt sbtVersion