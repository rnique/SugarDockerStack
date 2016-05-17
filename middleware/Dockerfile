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
# RUN sed -i -e '/ mpm_prefork_module /s/^/#/' -e '/ mpm_event_module /s/^#//' /etc/httpd/conf.modules.d/00-mpm.conf

# EXPOSE 9000

CMD ["php-fpm"]
