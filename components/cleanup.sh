#!/bin/bash

function usage {
  echo "$0 rmc | rmi | rmv | rma"
  echo "rmc    remove containers"
  echo "rmi    remove images"
  echo "rmv    remove volumes"
  echo "rma    remove contains & images & volumes"
}

function rmc {
  # 删除Exited容器
  CONTAINERS=$(docker ps -a | grep Exit | cut -d ' ' -f 1)
  if [ ! -z "$CONTAINERS" ]; then
    echo "$CONTAINERS" | xargs docker rm
  fi
}

function rmi {
  # 删除没有tag的镜像
  IMAGES=$(docker images -f "dangling=true" -q)
  if [ ! -z "$IMAGES" ]; then
    docker rmi $IMAGES
  fi
}

function rmv {
  # 删除volume, 会导致数据库数据丢失
  docker volume ls -q | xargs docker volume rm
}

case $1 in
  rmc)
    rmc
  ;;
  rmi)
    rmi
  ;;
  rmv)
    rmv
  ;;
  rma)
    rmc
    rmi
    rmv
  ;;
  *)
    usage
  ;;
esac