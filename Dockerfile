FROM mongo:latest

RUN mkdir /opt/mongo
ADD mongo_setup_users.sh /opt/mongo/mongo_setup_users.sh
ADD mongo_setup_repset.sh /opt/mongo/mongo_setup_repset.sh
RUN chmod 777 /opt/mongo

RUN mkdir /tmp/mongo
ADD mongodb-keyfile /tmp/mongo/mongodb-keyfile
RUN chmod 666 /tmp/mongo/mongodb-keyfile

ADD run.sh /run.sh

CMD ["/run.sh"]

