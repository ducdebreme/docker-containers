# This is a docker Drupal environment.

FROM        debian:latest
MAINTAINER  Stefan Kuehn <ducdebreme@early-dance.de>

ENV DRUSH_VERSION 6.4.0
ENV DEBIAN_FRONTEND noninteractive


# sudo docker build -t ducdebreme/lamp55_slim .
# sudo docker run --name test  -v $(pwd):/var/www -P -i -t ducdebreme/lamp55_slim bash
# sudo docker run --name tew -v $(pwd)/conf:/etc/conf  -P -i -t ducdebreme/lamp55_slim bash


##
# Apache.
##
# ENV http_proxy "http://00026898:Stefan1@165.222.184.232:8080"
# ENV https_proxy "http://00026898:Stefan1@165.222.184.232:8080"

# We add the stable PHP 5.5 repository.
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y wget && \
    apt-get -y install apache2 && \
    apt-get clean

# install php 5.5 (standard on debian wheezy would be 5.4)
RUN wget -qO- http://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
    echo "deb http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list.d/php55.list && \
    echo "deb-src http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list.d/php55.list && \
    apt-get update -y && \
    apt-get -y install php5 php5-curl php5-gd php-pear php5-mysql

RUN a2enmod rewrite php5

# mysql-client
RUN apt-get install -y openssh-client mysql-client rsync

# Composer.
# Phing.
# Drush.
# IRC.
# Xhprof.
RUN pear install Console_Table && \
    wget -qO- https://github.com/drush-ops/drush/archive/$DRUSH_VERSION.tar.gz | tar xvz -C /opt && \
    mv /opt/drush-$DRUSH_VERSION /opt/drush && \
    ln -s /opt/drush/drush /usr/local/bin/drush && \
    chmod -R 777 /opt/drush/lib


EXPOSE 80 

RUN mkdir -p /etc/conf

# startup script
ADD ./scripts/start.sh /root/start.sh
RUN chmod 755 /root/start.sh
CMD ["/root/start.sh"]
