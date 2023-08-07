#!/bin/bash

mkdir /app
cd /app
git clone https://github.com/raghudevopsb73/${COMPONENT}
cd ${COMPONENT}/schema

source /data/params

if [ "${SCHEMA_TYPE}" == "mongo" ]; then
  curl -s -L https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -O /app/rds-combined-ca-bundle.pem
  mongo --ssl --host ${DOCDB_ENDPOINT}:27017 --sslCAFile /app/rds-combined-ca-bundle.pem --username ${DOCDB_USERNAME} --password ${DOCDB_PASSWORD} </app/schema/${COMPONENT}.js
elif [ "${SCHEMA_TYPE}" == "mysql" ]; then
  echo show databases | mysql -h ${MYSQL_ENDPOINT} -u${MYSQL_USERNAME} -p${MYSQL_PASSWORD} | grep cities
  if [ $? -ne 0 ]; then
    mysql -h ${MYSQL_ENDPOINT} -u${MYSQL_USERNAME} -p${MYSQL_PASSWORD} </app/schema/${COMPONENT}.sql
  fi
else
  echo Invalid Schema Input
  exit 1
fi
