#!/bin/bash

export INST=test
export DOCROOT=$(pwd)
export CONFDIR=$(pwd)/conf
export MYSQL_ROOT_PASSWORD=samba

echo $INST
echo $DOCROOT
echo $CONFDIR

sudo docker rm -f "$INST-mysql" "$INST-lamp"

# start mysql
sudo docker run --name "$INST-mysql" -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -P -d ducdebreme/mysql-5.6

# start lamp
sudo docker run \
  --name "$INST-lamp" \
  --link "$INST-mysql":mysql \
  -v "$DOCROOT":/var/www \
  -v "$CONFDIR":/etc/conf \
  -P -d ducdebreme/lamp55_slim 

sudo docker ps  