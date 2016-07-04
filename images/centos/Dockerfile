FROM centos:7
MAINTAINER http://steperu.com
LABEL Vendor="STE PERU" \
      License=GPLv2

RUN yum -y --setopt=tsflags=nodocs install \
        epel-release \
        libzip \
        wget \
    && yum -y --setopt=tsflags=nodocs update \
    && yum clean all
