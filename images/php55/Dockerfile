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

ARG PHP_SESSION_SAVE_HANDLER=redis
ARG PHP_SESSION_SAVE_PATH="tcp://redis:6379"
ARG PHP_ERROR_LOG="/var/log/php-fpm-error.log"

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
        sendmail \
    && yum clean all

RUN set -ex \
    && cd /etc \
    && sed -i -e '/^error_log/s/^/;/' \
        -e '/^daemonize/s/^/;/' php-fpm.conf \
    && sed -i -e '/^listen.allowed_clients/s/^/;/' \
        -e 's/listen =/;&/' \
        -e '/session.save_handler/s/^/;/' \
        -e '/session.save_path/s/^/;/' \
        -e 's/pm =/;&/' \
        -e '/php_admin_value[error_log]/s/^/;/' ./php-fpm.d/www.conf \
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
        echo 'max_execution_time = 300'; \
        echo 'memory_limit = 256M'; \
        echo 'default_charset = "UTF-8"'; \
        echo 'session.gc_maxlifetime = 3600'; \
    } | tee -a php.ini \
    && { \
        echo '[global]'; \
        echo 'daemonize = no'; \
        echo 'error_log = ${PHP_ERROR_LOG}'; \
        echo; \
        echo '[www]'; \
        echo 'listen = 9000'; \
        echo 'pm.status_path = /php-status-page'; \
        echo 'pm = ondemand'; \
        echo 'pm.process_idle_timeout = 60'; \
        echo 'pm.max_requests = 120'; \
        echo; \
        echo '; if we send this to /proc/self/fd/1, it never appears'; \
        echo 'access.log = /proc/self/fd/2'; \
        echo; \
        echo 'clear_env = no'; \
        echo; \
        echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
        echo 'catch_workers_output = yes'; \
        echo; \
#        echo "php_admin_value[error_log] = ${PHP_ERROR_LOG}"; \
        echo "php_value[session.save_handler] = ${PHP_SESSION_SAVE_HANDLER}"; \
        echo "php_value[session.save_path] = ${PHP_SESSION_SAVE_PATH}"; \
    } | tee php-fpm.d/docker.conf

EXPOSE 9000

CMD ["php-fpm"]
