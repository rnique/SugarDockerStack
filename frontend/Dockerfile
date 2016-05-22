FROM centos:7
MAINTAINER http://www.centos.org
LABEL Vendor="CentOS"
LABEL License=GPLv2
LABEL Version=2.4.6-31

RUN yum -y update \
    && yum -y install \
        libevent \
        httpd \
    && yum clean all
RUN sed -i -e '/ mpm_prefork_module /s/^/#/' -e '/ mpm_event_module /s/^#//' /etc/httpd/conf.modules.d/00-mpm.conf

EXPOSE 80 443

COPY mpm_event_module.conf /etc/httpd/conf.d/mpm_event_module.conf
COPY security.conf /etc/httpd/conf.d/security.conf
COPY xtraparams.conf /etc/httpd/conf.d/xtraparams.conf

# Simple startup script to avoid some issues observed with container restart 
COPY run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]
