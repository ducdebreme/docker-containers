# This is a docker Drupal environment.

FROM        previousnext/base:latest
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

RUN apt-get update -y

##
# Apache.
##

RUN apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 libapache2-mod-php5 php5-curl php5-mysql php5-gd php5-mcrypt php-apc php-pear php5-pspell nullmailer mysql-server
ADD ./scripts/foreground.sh /etc/apache2/foreground.sh
RUN rm -rf /var/www/
RUN chmod 755 /etc/apache2/foreground.sh

# Mods.
RUN cd /etc/apache2/mods-enabled && ln -s ../mods-available/rewrite.load .

# vHost.
RUN rm -f /etc/apache2/sites-enabled/*
ADD ./conf/apache2/vhost.conf /etc/apache2/sites-available/drupal
RUN ln -s /etc/apache2/sites-available/drupal /etc/apache2/sites-enabled/drupal

##
# PHP.
##

ADD ./conf/php/php.ini /etc/php5/apache2/php.ini
ADD ./conf/php/php.ini /etc/php5/cli/php.ini

# Composer.
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

# Phing.
RUN pear channel-discover pear.phing.info
RUN pear install phing/phing

# Drush.
RUN pear channel-discover pear.drush.org
RUN pear install Console_Table
RUN pear install drush/drush

# IRC.
RUN pear install Net_SmartIRC

# Xhprof.
RUN apt-get install -y build-essential
RUN pear channel-update pear.php.net
RUN pecl install xhprof-beta

# Xdebug.
RUN apt-get install -y build-essential
RUN pear channel-update pear.php.net
RUN pecl install xdebug

##
# Mysql.
##

ADD ./conf/mysql/my.cnf /etc/mysql/my.cnf

##
# Cron.
##

ADD ./conf/cron/drupal /etc/cron.d/drupal

##
# Scripts.
#   This is where we add all our utlitiy scripts.
##

ADD ./scripts/permissions.sh /root/permissions.sh

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

# move up later
RUN mkdir -p /var/www
RUN a2enmod rewrite
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-xcache memcached php5-memcache p7zip unzip vim
ADD ./conf/memcached/supervisord-memcached.conf /etc/supervisor/conf.d/
ADD ./conf/apache2/envvars /etc/apache2/

# after mysql install: install DB
RUN rm -rf /var/lib/mysql/*
RUN mysql_install_db > /dev/null 2>&1




CMD ["/root/start.sh"]
