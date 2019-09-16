#!/bin/bash

# 校对时间
ntpd -p 1.cn.pool.ntp.org

function init {
  if [ -d "/conf/startup" ]; then
    RET=1
    while [[ RET -ne 0 ]]; do
  	  echo "=> Waiting for confirmation of drillbit service startup"
  	  sleep 5
  	  curl -s localhost:8047 > /dev/null
  	  RET=$?
    done

    # 延迟执行请求以减少drill处理报错
    sleep 5

    for SH in `ls /conf/startup/*.sh | sort -n`; do
      $SH
    done
  fi
}

init &

exec $DRILL_HOME/bin/drillbit.sh --config /conf run
