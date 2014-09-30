# This is a docker Drupal environment.

FROM        ducdebreme/base-14.04:latest
MAINTAINER  Stefan Kuehn <ducdebreme@early-dance.de>


##
# Apache.
##

# We add the stable PHP 5.5 repository.
RUN apt-get update -y && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 php5 libapache2-mod-php5 php5-curl php5-mysql php5-gd php5-mcrypt php-pear php5-dev php5-pspell nullmailer libssl-dev mysql-server memcached php5-memcache p7zip unzip vim telnet build-essential && \
    apt-get -y dist-upgrade && \
    apt-get clean
ADD ./scripts/foreground.sh /etc/apache2/foreground.sh
RUN rm -rf /var/www/
RUN chmod 755 /etc/apache2/foreground.sh

# This fixes missing file errors.
RUN touch /etc/apache2/httpd.conf
RUN mkdir /etc/apache2/conf.d

# Mods.
RUN cd /etc/apache2/mods-enabled && ln -s ../mods-available/rewrite.load .

# We are removing this because we deal with it in our own custom apache2.conf.
RUN rm /etc/apache2/mods-enabled/mpm_prefork.conf
ADD ./conf/apache2/envvars /etc/apache2/

# vHost.
RUN rm -f /etc/apache2/sites-enabled/*
ADD ./conf/apache2/vhost.conf /etc/apache2/sites-available/drupal.conf
RUN ln -s /etc/apache2/sites-available/drupal.conf /etc/apache2/sites-enabled/drupal.conf

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

# Drush.
ADD https://github.com/drush-ops/drush/archive/6.2.0.zip /tmp/drush.zip
RUN cd /tmp && unzip -d /tmp /tmp/drush.zip
RUN mv /tmp/drush-6.2.0 /opt/drush
RUN ln -s /opt/drush/drush /usr/local/bin/drush
RUN chmod -R 777 /opt/drush/lib




##
# Mysql.
##
ADD ./conf/mysql/my.cnf /etc/mysql/my.cnf
RUN rm -rf /var/lib/mysql/*
#RUN mysql_install_db > /dev/null 2>&1
RUN mysql_install_db 

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
