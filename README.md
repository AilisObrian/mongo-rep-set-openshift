# Dockerized MongoDB Replica Set

This MongoDB Docker container is intended to be used to set up a n nodes replica set.

Mongo version:  **latest**

## About

A MongoDB [replica set](https://docs.mongodb.org/v3.0/replication/) consists of at least 3 Mongo instances. In this case, they will be a primary, secondary, and an arbiter. To use this project as a replica set, you simply launch three instances of this container across three separate host servers and the primary will configure your users and replica set.  Also note that each server must be able to access the others (discovery must work in both directions).

## Setup

Before you build the container, you will need to create the keyfile that Mongo uses for [internal authentication](https://docs.mongodb.org/v3.0/tutorial/enable-internal-authentication/) between replica set members. Each of your members needs to have the same key. Do NOT commit your generated key to a public repo.

The file already exists in this repo (`mongodb-keyfile`), but it's blank.

#### Generate keyfile

From the root of this project, run the following:

```sh
openssl rand -base64 741 > mongodb-keyfile
```

#### Build

```sh
docker build -t yourname/mongo-rep-set:latest .
```

## Launch

Now you're ready to start launching containers.
You need to review the env variables within your docker-compose.yml

```sh
docker-compose up
```

#### Connect

After creating some user for your app, you can connect with

```sh
mongodb://[appUser]:[appPwd]@[mongo1]:27017,[mongo2]:27017,[mongo3]:27017/myAppDatabase?replicaSet=rs0
```