FROM        dokken/centos-8
RUN         yum install epel-release -y
COPY        mongo.repo /etc/yum.repod.d/mongo.repo
RUN         yum install mysql mongodb-org-shell -y
COPY        run.sh /run.sh
ENTRYPOINT  [ "bash", "/run.sh" ]
