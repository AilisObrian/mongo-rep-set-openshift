#!/bin/bash
set -m

#Needed for openshift...
if [ "$KEY_REP_SET" != "" ]; then
  rm -rf /opt/mongo/mongodb-keyfile
  echo $KEY_REP_SET >> /opt/mongo/mongodb-keyfile
  chmod 600 /opt/mongo/mongodb-keyfile
elif [ "$NO_AUTH" == "" ] || [ "$NO_AUTH" == "false" ]; then
  echo "KEY_REP_SET not defined"
  exit 0
fi

if [ "$MONGO_ROLE" == "primary" ]; then
  if [ "$NO_AUTH" == "" ] || [ "$NO_AUTH" == "false" ]; then
    /opt/mongo/mongo_setup_users.sh
  fi
fi

auth="--auth"
keyfile="--keyFile /opt/mongo/mongodb-keyfile"
if [ "$NO_AUTH" == "true" ]; then
  auth=""
  keyfile=""
fi

cmd="mongod --storageEngine wiredTiger $keyfile --replSet $REP_SET $auth"

if [ "$VERBOSE" == "yes" ]; then
  cmd="$cmd --verbose"
fi

$cmd &

if [ "$MONGO_ROLE" == "primary" ]; then
  /opt/mongo/mongo_setup_repset.sh
fi

fg
