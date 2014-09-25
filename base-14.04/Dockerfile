# This is a base container for PNX docker containers.

FROM        ubuntu:14.04
MAINTAINER  Stefan Kuehn <ducdebreme@early-dance.de>

##
# APT.
##

##
# Base.
##
RUN apt-get update && \
    apt-get -y upgrade && \
    dpkg-divert --local --rename --add /sbin/initctl && \ 
    ln -fs /bin/true /sbin/initctl && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install fail2ban vim git curl wget pwgen python-setuptools vim-tiny sudo python-software-properties cron unzip tar


##
# Users.
##

RUN useradd --create-home --shell /bin/bash --user-group deployer

##
# SSHD.
##

RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd

##
# Fail2ban.
##

RUN mkdir /var/run/fail2ban

##
# Rsyslog.
##

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install rsyslog rsyslog-doc
RUN sed -i 's/xconsole/console/g' /etc/rsyslog.d/*

##
# Startup scripts.
##

ADD ./scripts/start.sh /root/start.sh
RUN chmod 755 /root/start.sh

##
# Supervisord.
##

RUN easy_install supervisor
ADD ./conf/supervisor/supervisord.conf /etc/supervisord.conf
RUN mkdir /var/log/supervisor/
