# This is a docker Drupal environment for PNX QA and Staging.
#

FROM        debian:latest
MAINTAINER  Stefan Kuehn <ducdebreme@early-dance.de>

ENV SOLR_VERSION 3.6.2
ENV SOLR_INDEX_DIR solr-3.x
ENV DEBIAN_FRONTEND noninteractive

# ENV http_proxy "http://00026898:Stefan1@165.222.184.232:8080"
# ENV https_proxy "http://00026898:Stefan1@165.222.184.232:8080"


# install java
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y openjdk-7-jre-headless tar wget && \
    apt-get clean

##
# Configure Solr 4.x.
##

# download and extract apachesolr code - do it in one step to save image space
RUN mkdir -p /var && \
    wget -qO- http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/apache-solr-$SOLR_VERSION.tgz | tar xvz -C /var && \
    mv /var/solr-$SOLR_VERSION /var/solr 


# our data directory
RUN mkdir -p /etc/conf

VOLUME /var/solr/example/solr/conf
ADD ./conf/$SOLR_INDEX_DIR /etc/conf/solr-index


# Startup scripts.
ADD ./scripts/start.sh /root/start.sh
RUN chmod 755 /root/start.sh

EXPOSE 8983 

CMD ["/root/start.sh"]
