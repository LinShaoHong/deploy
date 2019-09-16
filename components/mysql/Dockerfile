FROM mysql:5.7.14

MAINTAINER summer

LABEL name="summer/mysql" version=5.7.14

ADD my.cnf /conf/my.cnf

RUN apt-get update && \
    apt-get install -y ntp && \
    mkdir -p /conf/init && \
    rm -rf /etc/mysql && \
    ln -s /conf /etc/mysql && \
    chmod 644 /conf/my.cnf && \
    rm -rf /docker-entrypoint-initdb.d && \
    ln -s /conf/init /docker-entrypoint-initdb.d

ADD ntp.conf /etc/ntp.conf
ADD startup.sh /usr/bin/startup.sh

ENTRYPOINT [ "startup.sh" ]
