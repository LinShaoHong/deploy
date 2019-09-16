FROM nginx:alpine

MAINTAINER summer

LABEL name="summer/nginx"

RUN apk add --no-cache bash && \
    rm -rf /etc/nginx/conf.d && \
    echo "daemon off;" > /etc/nginx/nginx.conf && \
    echo "include /conf/nginx.conf;" >> /etc/nginx/nginx.conf

ADD startup.sh /usr/bin/startup.sh

ENTRYPOINT [ "startup.sh" ]
