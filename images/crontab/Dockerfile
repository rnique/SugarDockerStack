FROM centos:7
MAINTAINER http://steperu.com
LABEL Vendor="STE PERU" \
      License=GPLv2

RUN yum -y --setopt=tsflags=nodocs update \
    && yum -y --setopt=tsflags=nodocs install \
        epel-release \
        libzip \
        mailcap \
        wget \
    && yum clean all

COPY start-cron.sh /usr/bin/start-cron.sh
RUN yum -y --setopt=tsflags=nodocs install \
        cronie \
        rsyslog \
        at \
    && yum clean all \
    && chmod +x /usr/bin/start-cron.sh \
    && touch /var/log/cron.log \
    && crontab /etc/crontab
