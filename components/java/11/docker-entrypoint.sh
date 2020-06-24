#!/bin/bash

set -e

# 校对时间
ntpd -p 1.cn.pool.ntp.org

size_in_bytes() {
  local S=$1
  if [[ "$S" == *k ]] || [[ "$S" == *K ]]; then
    S=${S:0:${#S}-1}
    S=$(expr $S \* 1024)
  elif [[ "$S" == *m ]] || [[ "$S" == *M ]]; then
    S=${S:0:${#S}-1}
    S=$(expr $S \* 1024 \* 1024)
  elif [[ "$S" == *g ]] || [[ "$S" == *G ]]; then
    S=${S:0:${#S}-1}
    S=$(expr $S \* 1024 \* 1024 \* 1024)
  fi
  echo $S
}

get_memory_limit_from_cgroup() {
  local ML=""
  if [ -f /sys/fs/cgroup/memory/memory.limit_in_bytes ]; then
    ML=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
    if [ ${#ML} -gt 12 ]; then
      # unlimited in docker container
      ML=""
    else
      local MR="$MEM_RESERVE"
      if [ -z "$MR" ]; then
        MR=128m
      fi
      MR=$(size_in_bytes $MR)
      ML=$(expr $ML - $MR)
    fi
  fi
  echo $ML
}

get_memory_limit_from_linux() {
  local ML=""
  if [ -f /proc/meminfo ]; then
    ML=$(cat /proc/meminfo | grep MemAvailable | awk '{print $2}')
    if [ -z "$ML" ]; then
      ML=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')
    fi
    if [ ! -z "$ML" ]; then
      ML=$(expr $ML \* 1024)
    fi
  fi
  echo $ML
}

get_memory_limit() {
  local ML=$(get_memory_limit_from_cgroup)
  if [ -z "$ML" ]; then
    ML=$(get_memory_limit_from_linux)
  fi
  if [ ! -z "$ML" ]; then
    ML=$(expr $ML / 1024 / 1024)
    if [ $ML -lt 1 ]; then
      ML=""
    else
      ML="${ML}m"
    fi
  fi
  echo $ML
}

if [ -z "$MEM_LIMIT" ]; then
  MEM_LIMIT=$(get_memory_limit)
fi

if [ ! -z "$MEM_LIMIT" ]; then
  export JAVA_OPTS="$JAVA_OPTS -Xmx$MEM_LIMIT"
fi

if [ -d /logs ]; then
  DATE=$(date +%Y%M%d%H%m%S)
  export JAVA_OPTS="$JAVA_OPTS -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/logs/dump-$DATE.hprof -XX:LogFile=/logs/hotspot-$DATE.log"
fi

export JAVA_OPTS="$JAVA_OPTS -XX:+PrintCommandLineFlags -XX:+PrintGC"

exec "$@"
