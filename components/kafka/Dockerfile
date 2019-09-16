FROM wurstmeister/kafka

LABEL name="summer/kafka"

ADD server.properties $KAFKA_HOME/config/server.properties

ADD startup.sh /usr/bin/startup.sh

ENTRYPOINT [ "startup.sh" ]