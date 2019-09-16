FROM mongo:4.2

MAINTAINER summer

ARG VERSION=4.2

LABEL name="summer/mongodb" version=$VERSION

ENV DB_ROOT_USER=root
ENV DB_ROOT_PASSWORD=1234
ENV DB_DATABASE=summer
ENV DB_USER=lin
ENV DB_PASSWORD=lin0411

ADD conf /conf
ADD startup.sh /usr/bin/startup.sh

ENTRYPOINT [ "startup.sh" ]
