# This is a docker Drupal environment.

FROM        previousnext/base:latest
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

##
# Apache.
##

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 libapache2-mod-php5 php5-curl php5-mysql php5-gd php-apc php-pear
ADD ./scripts/foreground.sh /etc/apache2/foreground.sh
RUN rm -rf /var/www/
RUN chmod 755 /etc/apache2/foreground.sh

# Mods.
RUN cd /etc/apache2/mods-enabled && ln -s ../mods-available/rewrite.load .

##
# Mysql.
##

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://mirrors.linsrv.net/mariadb/repo/5.5/ubuntu precise main'
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mariadb-server

##
# Supervisord.
##

ADD ./conf/supervisor/supervisord.conf /etc/supervisord.conf

##
# Startup scripts.
##

ADD ./scripts/start.sh /root/start.sh
RUN chmod 755 /root/start.sh

EXPOSE 22 80

CMD ["/root/start.sh"]