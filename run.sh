#!/bin/bash
set -m

#Needed for openshift...
if [ -n $KEY_REP_SET ]; then
    echo $KEY_REP_SET >> /opt/mongo/mongodb-keyfile
    chmod 600 /opt/mongo/mongodb-keyfile
fi

if [ "$MONGO_ROLE" == "primary" ]; then
  /opt/mongo/mongo_setup_users.sh
fi

mongodb_cmd="mongod --storageEngine wiredTiger --keyFile /opt/mongo/mongodb-keyfile"
cmd="$mongodb_cmd --replSet $REP_SET"

if [ "$VERBOSE" == "yes" ]; then
  cmd="$cmd --verbose"
fi

if [ "$AUTH" == "yes" ]; then
  cmd="$cmd --auth"
fi

$cmd &

if [ "$MONGO_ROLE" == "primary" ]; then
  /opt/mongo/mongo_setup_repset.sh
fi

fg
