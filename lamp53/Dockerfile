# This is a docker Drupal environment.

FROM        previousnext/base:latest
MAINTAINER  Stefan Kuehn <ducdebreme@early-dance.de>


##
# All apt-get at the start
##

RUN apt-get update -y && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 libapache2-mod-php5 php5-curl php5-mysql php5-gd php5-mcrypt php-pear php5-pspell nullmailer mysql-server php5-xcache memcached php5-memcache p7zip unzip vim telnet build-essential && \
    apt-get clean
ADD ./scripts/foreground.sh /etc/apache2/foreground.sh
RUN rm -rf /var/www/
RUN chmod 755 /etc/apache2/foreground.sh

# Mods.
RUN cd /etc/apache2/mods-enabled && ln -s ../mods-available/rewrite.load .

# Apache / vHost.
RUN rm -f /etc/apache2/sites-enabled/*
ADD ./conf/apache2/vhost.conf /etc/apache2/sites-available/drupal
RUN ln -s /etc/apache2/sites-available/drupal /etc/apache2/sites-enabled/drupal
ADD ./conf/apache2/envvars /etc/apache2/
RUN mkdir -p /var/www
RUN a2enmod rewrite

##
# PHP.
##

ADD ./conf/php/php.ini /etc/php5/apache2/php.ini
ADD ./conf/php/php.ini /etc/php5/cli/php.ini

# Composer.
# Phing.
# Drush.
# IRC.
# Xhprof.
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer && \
    pear channel-discover pear.phing.info && \
    pear install phing/phing && \
    pear channel-discover pear.drush.org && \
    pear install Console_Table && \
    pear install drush/drush && \
    pear install Net_SmartIRC && \
    pear channel-update pear.php.net && \
    pecl install xhprof-beta && \
    pear channel-update pear.php.net && \
    pecl install xdebug 


##
# Mysql.
##
ADD ./conf/mysql/my.cnf /etc/mysql/my.cnf
RUN rm -rf /var/lib/mysql/*
RUN mysql_install_db > /dev/null 2>&1

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

EXPOSE 22 80 3306



CMD ["/root/start.sh"]
