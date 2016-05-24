FROM centos:7
MAINTAINER http://steperu.com
LABEL Vendor="PHP"
LABEL License=GPLv2
LABEL Version=5.5.x
ARG PHP_SESSION_SAVE_HANDLER=redis
ARG PHP_SESSION_SAVE_PATH="tcp://redis:6379"

RUN yum -y --setopt=tsflags=nodocs update \
    && yum -y --setopt=tsflags=nodocs install \
        epel-release \
        libzip \
        mailcap \
        wget \
    && yum clean all

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 \
    && yum -y --setopt=tsflags=nodocs install https://centos7.iuscommunity.org/ius-release.rpm \
    && rpm --import /etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY \
    && yum -y --setopt=tsflags=nodocs install \
        php55u-fpm \
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
    && yum clean all \
    && set -ex \
	&& cd /etc \
    && sed -i -e '/^error_log/s/^/#/' -e '/^daemonize/s/^/#/' php-fpm.conf \
    && sed -i -e '/listen.allowed_clients/s/^/#/' ./php-fpm.d/www.conf \
	&& { \
		echo 'date.timezone = America/Lima'; \
		echo 'display_errors = 0'; \
		echo 'fastcgi.logging = 0'; \
		echo 'mbstring.func_overload = 0'; \
		echo 'post_max_size = 100M'; \
		echo 'session.use_cookies = 1'; \
		echo 'session.cookie_httponly = 1'; \
		echo 'session.use_trans_sid = 0'; \
		echo 'upload_max_filesize = 99M'; \
		echo 'max_execution_time = 120'; \
		echo 'memory_limit = 256M'; \
		echo 'default_charset = "UTF-8"'; \
		echo 'session.gc_maxlifetime = 36000'; \        
	} | tee -a php.ini \
	&& { \
		echo '[global]'; \
		echo 'daemonize = no'; \
		echo 'error_log = /proc/self/fd/2'; \
		echo; \
		echo '[www]'; \
		echo 'listen = 9000'; \
        echo 'pm.status_path = /php-status-page'; \
        echo 'pm = ondemand'; \
		echo; \
		echo '; if we send this to /proc/self/fd/1, it never appears'; \
		echo 'access.log = /proc/self/fd/2'; \
		echo; \
		echo 'clear_env = no'; \
		echo; \
		echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
		echo 'catch_workers_output = yes'; \
		echo "php_value[session.save_handler] = ${PHP_SESSION_SAVE_HANDLER}"; \
		echo "php_value[session.save_path] = ${PHP_SESSION_SAVE_PATH}"; \
	} | tee php-fpm.d/zz-docker.conf

EXPOSE 9000

CMD ["php-fpm"]
