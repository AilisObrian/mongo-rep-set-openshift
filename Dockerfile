FROM mongo:latest

RUN mkdir /opt/mongo
ADD mongodb-keyfile /opt/mongo/mongodb-keyfile
ADD mongo_setup_users.sh /opt/mongo/mongo_setup_users.sh
ADD mongo_setup_repset.sh /opt/mongo/mongo_setup_repset.sh

ADD run.sh /run.sh
#RUN chown -R mongodb:mongodb /opt/mongo
#RUN chmod 600 /opt/mongo/mongodb-keyfile

RUN chgrp -R 0 /opt/mongo/
RUN chmod -R g+rw /opt/mongo/
RUN find /opt/mongo/ -type d -exec chmod g+x {} +
RUN chmod 600 /opt/mongo/mongodb-keyfile

CMD ["/run.sh"]

#FROM mongo:latest
#
#RUN mkdir /opt/mongo
#ADD mongo_setup_users.sh /opt/mongo/mongo_setup_users.sh
#ADD mongo_setup_repset.sh /opt/mongo/mongo_setup_repset.sh
#RUN chmod 777 /opt/mongo
#
#RUN mkdir /tmp/mongo
#ADD mongodb-keyfile /tmp/mongo/mongodb-keyfile
#RUN chmod 666 /tmp/mongo/mongodb-keyfile
#
#ADD run.sh /run.sh
#
#CMD ["/run.sh"]

