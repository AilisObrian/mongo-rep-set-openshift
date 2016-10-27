# Dockerized MongoDB Replica Set

This MongoDB Docker container is intended to be used to set up a N nodes replica set.

Mongo version:  **latest**

### Build

```sh
docker build -t bappr/mongo-rep-set:latest .
```

### Environnement variables

Node with primary role will create user and initiate the replicaset.
Role is not related to MongoDB state.

Env var | Value | Description | Comment | Only if Authentication enabled | Only if Primary
------------ | ------------- | ------------- | ------------- | ------------- | -------------
MONGO_ROLE | [primary] / [secondary]| | Only 1 primary in your cluster | No | No
REP_SET | String | Name of the repset | Must be the same on each node | No | No
NO_AUTH | [true] / [false]  | If authentication enabled | Must be the same on each node | No | No
| | |
KEY_REP_SET | String | Key for the authenticate nodes each other | Must be the same on each node | Yes | No
| | |
MONGO_CONF_REPSET | See example in docker-compose.yml | Configuration of the repset | | Yes | Yes
MONGO_ROOT_USER | String | User for root role | |Yes | Yes
MONGO_ROOT_PASSWORD | String | Password for user with root role | | Yes | Yes

### Launch

Now you're ready to start launching containers.

```sh
docker-compose up
```

### Connect

After creating some user for your app, you can connect with

```sh
mongodb://[appUser]:[appPwd]@localhost:27017,localhost:27018,localhost:27019/myAppDatabase?replicaSet=rs0
```

Port and RepSet are based on default docker-compose
