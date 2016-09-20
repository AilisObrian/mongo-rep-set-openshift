FROM mongo:latest

RUN mkdir /opt/mongo
ADD mongodb-keyfile /tmp/mongo/mongodb-keyfile
ADD mongo_setup_users.sh /opt/mongo/mongo_setup_users.sh
ADD mongo_setup_repset.sh /opt/mongo/mongo_setup_repset.sh

ADD run.sh /run.sh
RUN chown -R mongodb:mongodb /opt/mongo
RUN chmod 666 /tmp/mongo/mongodb-keyfile
RUN chmod -R 777 /opt/mongo

CMD ["/run.sh"]
