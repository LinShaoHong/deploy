FROM openjdk:8-jdk-alpine

MAINTAINER summer

ARG VERSION=1.16.0
ARG DRILL_HOME=/opt/drill

LABEL name="summer/drill" version=$VERSION

ENV DRILL_HOME=$DRILL_HOME
ENV DRILL_CLUSTER_ID=drill
ENV DRILL_ZK_CONNECT=zookeeper:2181

RUN apk add --no-cache bash curl wget && \
    mkdir -p $DRILL_HOME /conf && \
    wget --progress=bar:force "http://mirror.bit.edu.cn/apache/drill/drill-${VERSION}/apache-drill-${VERSION}.tar.gz" -O /tmp/drill.tar.gz && \
    tar zxf /tmp/drill.tar.gz -C /tmp && \
    mv /tmp/apache-drill-${VERSION}/* $DRILL_HOME/ && \
    cp -R $DRILL_HOME/conf/* /conf/ && \
    rm -rf /tmp/drill.tar.gz apache-drill-${VERSION} $DRILL_HOME/conf && \
    apk del --no-cache wget && \
    echo "$VERSION" > $DRILL_HOME/build.version

ADD drill-override.conf /conf/drill-override.conf
ADD startup.sh /usr/bin/startup.sh

EXPOSE 8047

WORKDIR $DRILL_HOME

ENTRYPOINT [ "startup.sh" ]
