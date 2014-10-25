#!/bin/bash

##
# Copy files into specific directories.
##

# apache
if [ -f '/etc/conf/apache2/vhost.conf' ]; then
  rm -f /etc/apache2/sites-enabled/*
  cp /etc/conf/apache2/vhost.conf /etc/apache2/sites-available/drupal
  a2ensite drupal
fi

# php
if [ -f '/etc/conf/php/php.ini' ]; then
  cp /etc/conf/php/php.ini /etc/php5/apache2/php.ini
  cp /etc/conf/php/php.ini /etc/php5/cli/php.ini
fi

# make php file executable
find /var/www/ -name '*.php' -exec chmod +x {} \;

# start apache
/usr/sbin/apache2ctl -D FOREGROUND
