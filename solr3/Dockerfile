# This is a docker Drupal environment for PNX QA and Staging.
#

FROM        previousnext/base:latest
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

ENV SOLR_VERSION 3.6.2

##
# Packages.
##

RUN apt-get install -y openjdk-7-jre-headless tar  vim telnet

##
# Configure Solr 3.x.
##

RUN mkdir -p /var
ADD http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/apache-solr-$SOLR_VERSION.tgz /var/apache-solr-$SOLR_VERSION.tgz
RUN tar -C /var --extract --file /var/apache-solr-$SOLR_VERSION.tgz
RUN mv /var/apache-solr-$SOLR_VERSION /var/solr

##
# Add search_api configuration.
##

ADD ./conf/solr /var/search_api
RUN rsync -avz /var/search_api/* /var/solr/example/solr/conf/

##
# Startup scripts.
##

ADD ./scripts/start.sh /root/start.sh
RUN chmod 755 /root/start.sh

##
# Setup supervisord.
##

ADD ./conf/supervisor/supervisord.conf /etc/supervisord.conf

EXPOSE 8983

CMD ["/root/start.sh"]
