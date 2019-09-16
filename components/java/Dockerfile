FROM anapsix/alpine-java:8

LABEL name="summer/oracle-jre"

MAINTAINER summer

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN apk --no-cache add bash

ENTRYPOINT [ "/docker-entrypoint.sh" ]
