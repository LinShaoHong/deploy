FROM redis:4.0-alpine

MAINTAINER summer

LABEL name="summer/redis" version=4.0

ADD redis.conf /conf/redis.conf

CMD [ "redis-server","/conf/redis.conf" ]
