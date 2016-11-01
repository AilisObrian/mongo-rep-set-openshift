FROM mongo:3.2

ARG KEY_REP_SET

RUN mkdir /opt/mongo
ADD scripts/mongo_setup_users.sh /opt/mongo/mongo_setup_users.sh
ADD scripts/mongo_setup_repset.sh /opt/mongo/mongo_setup_repset.sh
ADD scripts/run.sh /opt/mongo/run.sh

RUN echo $KEY_REP_SET >> /opt/mongo/mongodb-keyfile
RUN chmod 600 /opt/mongo/mongodb-keyfile

RUN chown -R mongodb:mongodb /opt/mongo

USER mongodb

CMD ["/opt/mongo/run.sh"]

