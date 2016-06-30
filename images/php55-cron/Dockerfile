FROM rnique/php55
MAINTAINER http://steperu.com
LABEL Vendor="STE PERU" \
      License=GPLv2

COPY start-cron.sh /usr/local/bin/start-cron.sh

RUN yum -y --setopt=tsflags=nodocs install \
        cronie \
        rsyslog \
        at \
    && yum clean all \
    && chmod +x /usr/local/bin/start-cron.sh \
    && ln -s /usr/local/bin/start-cron.sh / \
    && touch /var/log/cron.log \
    && crontab /etc/crontab

CMD ["/start-cron.sh"]

