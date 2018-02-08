#
# Basic image with scala and sbt
#

# FROM frolvlad/alpine-oraclejdk8:slim
FROM openjdk:jre-alpine
MAINTAINER Luca Ponzanelli

ENV SCALA_VERSION=2.12.4 
ENV SCALA_HOME=/usr/local/scala 
ENV SBT_VERSION=1.1.0 
ENV SBT_HOME=/usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin
ENV PATH ${PATH}:${SCALA_HOME}/bin

RUN apk add --no-cache --virtual=.build-dependencies bash wget ca-certificates
RUN apk add bash
RUN mkdir -p ${SCALA_HOME} ${SBT_HOME}
RUN wget -qO - --no-check-certificate "http://scala-lang.org/files/archive/scala-${SCALA_VERSION}.tgz" | tar xz -C $SCALA_HOME --strip-components=1 
RUN wget -qO - --no-check-certificate https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz  | tar xz -C $SBT_HOME --strip-components=1
RUN apk del .build-dependencies wget
RUN sbt sbtVersion

