#!/bin/bash
set -m

cp /opt/mongo/mongodb-keyfile /opt/mongo/mongodb-keyfile-os
chmod 600 /opt/mongo/mongodb-keyfile-os

already_set=false
if [ "$(ls -A /data/db)" ]; then
  echo "************************************************************"
  echo "Node not empty..."
  echo "************************************************************"
  already_set=true
fi

if [ "$MONGO_ROLE" == "primary" ] && [ $already_set == false ]; then
  if [ "$NO_AUTH" == "" ] || [ "$NO_AUTH" == "false" ]; then
    /opt/mongo/mongo_setup_users.sh
  fi
fi

auth="--auth"
keyfile="--keyFile /opt/mongo/mongodb-keyfile-os"
if [ "$NO_AUTH" == "true" ]; then
  auth=""
  keyfile=""
fi

cmd="mongod --storageEngine wiredTiger $keyfile --replSet $REP_SET $auth"

if [ "$VERBOSE" == "yes" ]; then
  cmd="$cmd --verbose"
fi

$cmd &

if [ "$MONGO_ROLE" == "primary" ]  && [ $already_set == false ]; then
  /opt/mongo/mongo_setup_repset.sh
fi

fg
