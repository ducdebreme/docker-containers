#! /bin/sh

# Name: permissions.sh
# Author: Nick Schuch (nick@pnx.com.au)
# Comment: This is a script to enforce permissions best practices.

BASE='/var/www'
USER='www-data'
GROUP='www-data'

setPermissions() {
  # Public files.
  chown -R ${USER}:${GROUP} ${BASE}
  find ${BASE} -type d -exec chmod 2775 {} \;
  find ${BASE} -type f -exec chmod 664 {} \;

  # root 
  chown -R root:root /root

  # Make sure we have a paper trail.
  logger Permissions have been updated.
}

while true; do
  setPermissions
  sleep 15m
done
