FROM rnique/centos:7
MAINTAINER http://steperu.com
LABEL Vendor="STE PERU" \
      License=GPLv2

# Install server

RUN rpmkeys --import https://www.percona.com/downloads/RPM-GPG-KEY-percona \
    && yum install -y http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm \
    && yum install -y --setopt=tsflags=nodocs which Percona-Server-server-57 Percona-Server-client-57 Percona-Server-shared-57 Percona-Server-tokudb-57 \
    && yum clean all

# comment out a few problematic configuration values
# don't reverse lookup hostnames, they are usually another container
RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/my.cnf \
	&& echo 'skip-host-cache\nskip-name-resolve' | awk '{ print } $1 == "[mysqld]" && c == 0 { c = 1; system("cat") }' /etc/my.cnf > /tmp/my.cnf \
	&& mv /tmp/my.cnf /etc/my.cnf

COPY ps-entry.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh \
    && ln -s /usr/local/bin/entrypoint.sh / \
    && mkdir /docker-entrypoint-initdb.d

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3306
CMD [""]
