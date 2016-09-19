#!/bin/bash

mongodb_setup_cmd="mongod --storageEngine wiredTiger"

$mongodb_setup_cmd &

fg

mongo admin --eval "help" > /dev/null 2>&1
RET=$?

while [[ RET -ne 0 ]]; do
  echo "Waiting for MongoDB to start..."
  mongo admin --eval "help" > /dev/null 2>&1
  RET=$?
  sleep 1
done

echo "************************************************************"
echo "Setting up users..."
echo "************************************************************"

# create root user
mongo admin --eval "db.createUser({user: '$MONGO_ROOT_USER', pwd: '$MONGO_ROOT_PASSWORD', roles:[{ role: 'root', db: 'admin' }]});"

echo "************************************************************"
echo "Shutting down"
echo "************************************************************"
mongo admin --eval "db.shutdownServer();"

sleep 3
