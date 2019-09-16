#!/bin/bash

if [ ! -f /data/storage.bson ]; then
  mongod -f /conf/mongodb.conf &

  RET=1
  while [[ RET -ne 0 ]]; do
      echo "=> Waiting for confirmation of MongoDB service startup"
      sleep 5
      mongo admin --eval "help" >/dev/null 2>&1
      RET=$?
  done

  echo "=> Run initialization script"

  /conf/init.sh

  mongod -f /conf/mongodb.conf --shutdown
fi

echo "=> Start MongoDB with authentication"

exec mongod -f /conf/mongodb.conf --auth $@