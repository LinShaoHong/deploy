FROM kibana:5.5.2

LABEL name="summer/kibana"

MAINTAINER summer

ARG KIBANA_HOME=/usr/share/kibana

ENV KIBANA_HOME=$KIBANA_HOME

ADD kibana.yml $KIBANA_HOME/config/kibana.yml

CMD ["kibana"]