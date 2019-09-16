#!/bin/bash

mongo << EOF
    use admin;
    db.createUser({user: "${DB_ROOT_USER}", pwd: "${DB_ROOT_PASSWORD}", roles:['root']});
EOF

if [ ! -z "$DB_DATABASE" ]; then
mongo << EOF
    use admin;
    db.createUser({user: "${DB_USER}", pwd: "${DB_PASSWORD}", roles:[{role:'readWrite',db:'${DB_DATABASE}'}, {role:'dbAdmin',db:'${DB_DATABASE}'}]});
EOF
fi

if [ -d /conf/init ]; then
  for SH in `ls /conf/init/*.sh | sort -n`; do
    $SH
  done
fi