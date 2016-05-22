FROM centos:7
MAINTAINER http://steperu.com
LABEL Vendor="PHP"
LABEL License=GPLv2
LABEL Version=5.5.x

RUN yum -y update \
    && yum -y install \
        epel-release \
        libzip \
        mailcap \
    && rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 \
    && yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
    && rpm --import /etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY \
    && yum clean all
RUN yum -y install \
    php55u-fpm \
#    php55u \
    php55u-bcmath \
    php55u-common \
    php55u-gd \
    php55u-imap \
    php55u-ldap \
    php55u-mbstring \
    php55u-mcrypt \
    php55u-mysqlnd \
    php55u-opcache \
    php55u-pecl-redis \
    php55u-xml \
    && yum clean all

RUN set -ex \
	&& cd /etc \
    && sed -i -e '/^error_log/s/^/#/' -e '/^daemonize/s/^/#/' /etc/php-fpm.conf \
	&& { \
		echo '[global]'; \
		echo 'error_log = /proc/self/fd/2'; \
		echo; \
		echo '[www]'; \
		echo '; if we send this to /proc/self/fd/1, it never appears'; \
		echo 'access.log = /proc/self/fd/2'; \
		echo; \
		echo 'clear_env = no'; \
		echo; \
		echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
		echo 'catch_workers_output = yes'; \
	} | tee php-fpm.d/docker.conf \
	&& { \
		echo '[global]'; \
		echo 'daemonize = no'; \
		echo; \
		echo '[www]'; \
		echo 'listen = 9000'; \
#        echo 'pm = ondemand'; \
	} | tee php-fpm.d/zz-docker.conf

# EXPOSE 9000

CMD ["php-fpm"]
