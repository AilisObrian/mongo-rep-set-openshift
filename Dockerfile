FROM mongo:latest

RUN mkdir /opt/mongo
ADD mongo_setup_users.sh /opt/mongo/mongo_setup_users.sh
ADD mongo_setup_repset.sh /opt/mongo/mongo_setup_repset.sh
RUN chmod 777 /opt/mongo

ADD run.sh /run.sh

CMD ["/run.sh"]

