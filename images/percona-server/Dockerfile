FROM centos:7
MAINTAINER http://steperu.com
LABEL Vendor="STE PERU" \
      License=GPLv2

RUN yum -y --setopt=tsflags=nodocs update \
    && yum -y --setopt=tsflags=nodocs install \
        epel-release \
        libzip \
        wget \
    && yum clean all

RUN rpmkeys --import https://www.percona.com/downloads/RPM-GPG-KEY-percona

RUN yum install -y http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm \
    && yum install -y --setopt=tsflags=nodocs which Percona-Server-server-57 Percona-Server-client-57 Percona-Server-shared-57 Percona-Server-tokudb-57 \
    && yum clean all

# Install server

# comment out a few problematic configuration values
# don't reverse lookup hostnames, they are usually another container
RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf \
	&& echo 'skip-host-cache\nskip-name-resolve' | awk '{ print } $1 == "[mysqld]" && c == 0 { c = 1; system("cat") }' /etc/mysql/my.cnf > /tmp/my.cnf \
	&& mv /tmp/my.cnf /etc/mysql/my.cnf

RUN mkdir /docker-entrypoint-initdb.d

VOLUME ["/var/lib/mysql", "/var/log/mysql"]

COPY ps-entry.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD [""]
