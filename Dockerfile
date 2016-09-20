FROM mongo:latest

RUN mkdir /opt/mongo
ADD mongodb-keyfile /opt/mongo/mongodb-keyfile
ADD mongo_setup_users.sh /opt/mongo/mongo_setup_users.sh
ADD mongo_setup_repset.sh /opt/mongo/mongo_setup_repset.sh

ADD run.sh /run.sh
RUN chown -R root:root /opt/mongo
RUN chmod 600 /opt/mongo/mongodb-keyfile

CMD ["/run.sh"]
