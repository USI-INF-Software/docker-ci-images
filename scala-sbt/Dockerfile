FROM alpine

# Java version: 1.8.0_171-b11
ENV JAVA_VERSION=8
ENV JAVA_UPDATE=171
ENV JAVA_BUILD=11
ENV JAVA_PATH=512cd62ec5174c3487ac17c61aaa89e8
ENV JAVA_HOME=/usr/lib/jvm/default-jvm
ENV JAVA_DOWNLOAD=jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz
ENV SCALA_VERSION=2.12.4 
ENV SCALA_HOME=/usr/local/scala 
ENV SBT_VERSION=1.1.0 
ENV SBT_HOME=/usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin
ENV PATH ${PATH}:${SCALA_HOME}/bin
ENV PATH ${PATH}:${JAVA_HOME}/bin

# Install dependencies
RUN apk add --no-cache --virtual=.build-dependencies wget unzip && \
    apk add --update bash git openssh-client ca-certificates  && \
    eval $(ssh-agent -s) && \
    wget -qO /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk && \
    apk add glibc-2.25-r0.apk && \
    rm /etc/apk/keys/sgerrand.rsa.pub glibc-2.25-r0.apk

# Install Oracle JDK
RUN mkdir -p ${JAVA_HOME}
RUN wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" -qO - \
        "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" | tar xz -C ${JAVA_HOME} --strip-components=1
RUN rm -rf "$JAVA_HOME/"*src.zip
RUN wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip"
RUN unzip -jo -d "${JAVA_HOME}/jre/lib/security" "jce_policy-${JAVA_VERSION}.zip"
RUN rm "${JAVA_HOME}/jre/lib/security/README.txt"

# Install Scala & SBT
RUN mkdir -p ${SCALA_HOME} ${SBT_HOME}
RUN wget -qO - --no-check-certificate "http://scala-lang.org/files/archive/scala-${SCALA_VERSION}.tgz" | tar xz -C $SCALA_HOME --strip-components=1
RUN wget -qO - --no-check-certificate https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz  | tar xz -C $SBT_HOME --strip-components=1
RUN apk del .build-dependencies
RUN sbt sbtVersion