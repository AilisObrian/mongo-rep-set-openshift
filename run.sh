#!/bin/bash
set -m

##Needed for openshift...
#cp /tmp/mongo/mongodb-keyfile /opt/mongo/mongodb-keyfile
#chmod 600 /opt/mongo/mongodb-keyfile

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
