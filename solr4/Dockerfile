# This is a docker Drupal environment for PNX QA and Staging.
#

FROM        previousnext/base:latest
MAINTAINER  Stefan Kuehn <ducdebreme@early-dance.de>

ENV SOLR_VERSION 4.9.0

##
# Packages.
##

RUN apt-get install -y openjdk-7-jre-headless tar  && \
    apt-get clean

##
# Configure Solr 4.x.
##

# download and extract apachesolr code - do it in one step to save image space
RUN mkdir -p /var && \
    wget -qO- http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz | tar xvz -C /var && \
    mv /var/solr-$SOLR_VERSION /var/solr 

##
# Add search_api configuration.
##

ADD ./conf/solr /var/search_api
RUN rsync -avz /var/search_api/* /var/solr/example/solr/collection1/conf/

##
# Startup scripts.
##

ADD ./scripts/start.sh /root/start.sh
RUN chmod 755 /root/start.sh

##
# Setup supervisord.
##

ADD ./conf/supervisor/supervisord.conf /etc/supervisord.conf

EXPOSE 8983 22

CMD ["/root/start.sh"]
