#!/bin/bash

# 校对时间
ntpd -p 1.cn.pool.ntp.org

exec $ES_HOME/bin/elasticsearch