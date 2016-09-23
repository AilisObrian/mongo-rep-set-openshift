# Dockerized MongoDB Replica Set

This MongoDB Docker container is intended to be used to set up a N nodes replica set.

Mongo version:  **latest**

#### Build

```sh
docker build -t bappr/mongo-rep-set:latest .
```

## Launch

Now you're ready to start launching containers.
You can review the env variables within your docker-compose.yml

```sh
docker-compose up
```

#### Connect

After creating some user for your app, you can connect with

```sh
mongodb://[appUser]:[appPwd]@localhost:27018,localhost:27018,localhost:27019/myAppDatabase?replicaSet=rs0
```

Port and RepSet are based on default docker-compose