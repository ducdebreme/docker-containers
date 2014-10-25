#!/bin/bash

##
# Copy files into specific directories.
##

# copy custom solr index over default index
if [ -f '/etc/conf/solr-index/*' ]; then
  cp -R /etc/conf/solr-index/* /var/solr/example/solr/collection1/conf
fi


# start solr
cd /var/solr/example; java -Xmx256m -jar start.jar
