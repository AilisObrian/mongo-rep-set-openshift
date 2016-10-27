#!/bin/bash

echo "************************************************************"
echo "Setting up replica set"
echo "************************************************************"

mongo admin --eval "help" > /dev/null 2>&1
RET=$?

while [[ RET -ne 0 ]]; do
  echo "Waiting for MongoDB to start..."
  mongo admin --eval "help" > /dev/null 2>&1
  RET=$?
  sleep 1

  if [[ -f /data/db/mongod.lock ]]; then
    echo "Removing Mongo lock file"
    rm /data/db/mongod.lock
  fi
done

# configure replica set
credentials="-u $MONGO_ROOT_USER -p $MONGO_ROOT_PASSWORD"
if [ "$NO_AUTH" == "true" ]; then
  credentials=""
fi

mongo admin $credentials --eval "rs.initiate($MONGO_CONF_REPSET);"