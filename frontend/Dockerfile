FROM centos:7
MAINTAINER http://www.centos.org
LABEL Vendor="CentOS"
LABEL License=GPLv2
LABEL Version=2.4.6-31

RUN yum -y update && yum clean all
RUN yum -y install yum-utils epel-release centos-release-scl libzip libevent && yum -y install httpd && yum clean all

EXPOSE 80

# Simple startup script to avoid some issues observed with container restart 
COPY run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]
