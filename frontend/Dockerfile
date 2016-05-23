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
RUN sed -i -e '/ mpm_prefork_module /s/^/#/' \
        -e '/ mpm_event_module /s/^#//' /etc/httpd/conf.modules.d/00-mpm.conf \
    && sed -i -e '/ access_compat_module /s/^/#/' \
        -e '/ actions_module /s/^/#/' \
        -e '/ allowmethods_module /s/^/#/' \
        -e '/ authn_anon_module /s/^/#/' \
        -e '/ authn_dbm_module /s/^/#/' \
        -e '/ authz_dbm_module /s/^/#/' \
        -e '/ authz_owner_module /s/^/#/' \
        -e '/ cache_disk_module /s/^/#/' \
        -e '/ cache_module /s/^/#/' \
        -e '/ ext_filter_module /s/^/#/' \
        -e '/ include_module /s/^/#/' \
        -e '/ info_module /s/^/#/' \
        -e '/ remoteip_module /s/^/#/' \
        -e '/ slotmem_plain_module /s/^/#/' \
        -e '/ socache_memcache_module /s/^/#/' \
        -e '/ status_module /s/^/#/' \
        -e '/ substitute_module /s/^/#/' \
        -e '/ suexec_module /s/^/#/' \
        -e '/ userdir_module /s/^/#/' \
        -e '/ version_module /s/^/#/' \
        -e '/ vhost_alias_module /s/^/#/' \
        /etc/httpd/conf.modules.d/00-base.conf

EXPOSE 80 443

COPY mpm_event_module.conf /etc/httpd/conf.d/mpm_event_module.conf
COPY security.conf /etc/httpd/conf.d/security.conf
COPY xtraparams.conf /etc/httpd/conf.d/xtraparams.conf

# Simple startup script to avoid some issues observed with container restart 
COPY run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]
