#!/bin/bash
set -m

if [ "$MONGO_ROLE" == "primary" ]; then
  /opt/mongo/mongo_setup_users.sh
fi

whoami
mongodb_cmd="mongod --storageEngine wiredTiger --keyFile /opt/mongo/mongodb-keyfile"
cmd="$mongodb_cmd --replSet $REP_SET"

if [ "$AUTH" == "yes" ]; then
  cmd="$cmd --auth"
fi

$cmd &

if [ "$MONGO_ROLE" == "primary" ]; then
  /opt/mongo/mongo_setup_repset.sh
fi

fg
