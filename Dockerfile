FROM mongo:latest

RUN mkdir /opt/mongo
VOLUME /opt/mongo

ADD scripts/mongo_setup_users.sh /opt/mongo/mongo_setup_users.sh
ADD scripts/mongo_setup_repset.sh /opt/mongo/mongo_setup_repset.sh
ADD scripts/run.sh /opt/mongo/run.sh

#Needed for Openshift...
RUN chmod 777 /opt/mongo

CMD ["/opt/mongo/run.sh"]

