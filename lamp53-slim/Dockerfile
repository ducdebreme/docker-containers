# This is a docker Drupal environment.

FROM        debian:latest
MAINTAINER  Stefan Kuehn <ducdebreme@early-dance.de>

##
# Apache.
##
ENV http_proxy "http://00026898:Stefan1@165.222.184.232:8080"
ENV https_proxy "http://00026898:Stefan1@165.222.184.232:8080"

# We add the stable PHP 5.5 repository.
RUN apt-get update -y && \
    apt-get upgrade -y 
RUN    DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 php5 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt php-pear php5-pspell  && \
    apt-get clean
RUN rm -rf /var/www/


EXPOSE 22 80 3306