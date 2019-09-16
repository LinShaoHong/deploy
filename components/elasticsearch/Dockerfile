FROM elasticsearch:alpine

MAINTAINER summer

LABEL name="summer/elasticsearch" version=5.6.3

ENV ES_HOME=/usr/share/elasticsearch

RUN apk update && \
    apk add --no-cache wget && \
    wget --progress=bar:force --no-check-certificate \
      https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.6.3/elasticsearch-analysis-ik-5.6.3.zip \
      -O /tmp/ik.zip && \
    mkdir -p $ES_HOME/plugins/ik && \
    unzip /tmp/ik.zip -d $ES_HOME/plugins/ && \
    cp -R $ES_HOME/plugins/elasticsearch/* $ES_HOME/plugins/ik/ && \
    rm -rf $ES_HOME/plugins/elasticsearch && \
    rm /tmp/ik.zip && \
    apk del --no-cache wget

USER elasticsearch

ADD elasticsearch.yml $ES_HOME/config/elasticsearch.yml
ADD startup.sh /usr/bin/startup.sh

ENTRYPOINT [ "startup.sh" ]
