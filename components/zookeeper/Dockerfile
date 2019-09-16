FROM zookeeper:3.4.14

MAINTAINER summer

LABEL name="summer/zookeeper"

ADD zoo.cfg /conf/zoo.cfg

CMD ["zkServer.sh", "start-foreground"]
