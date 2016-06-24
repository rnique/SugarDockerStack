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

RUN yum -y --setopt=tsflags=nodocs install \
        httpd \
        libevent \
        at \
    && yum clean all \
    && wget -nv https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_x86_64.rpm \
    && rpm -U mod-pagespeed-stable_current_x86_64.rpm 2>/dev/null \
    && rm mod-pagespeed-stable_current_x86_64.rpm

# Simple startup script to avoid some issues observed with container restart 
COPY run-httpd.sh /usr/bin/run-httpd.sh

RUN sed -i -e '/ mpm_prefork_module /s/^/#/' \
        -e '/ mpm_event_module /s/^#//' \
        /etc/httpd/conf.modules.d/00-mpm.conf \
    && sed -i -e '/ actions_module /s/^/#/' \
        -e '/ allowmethods_module /s/^/#/' \
        -e '/ authn_anon_module /s/^/#/' \
        -e '/ auth_digest_module /s/^/#/' \
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
        /etc/httpd/conf.modules.d/00-base.conf \
    && sed -i -e '/ dav_module /s/^/#/' \
        -e '/ dav_fs_module /s/^/#/' \
        -e '/ dav_lock_module /s/^/#/' \
        /etc/httpd/conf.modules.d/00-dav.conf \
    && sed -i -e '/ lua_module /s/^/#/' \
        /etc/httpd/conf.modules.d/00-lua.conf \
    && sed -i -e '/ lbmethod_bybusyness_module /s/^/#/' \
        -e '/ lbmethod_byrequests_module /s/^/#/' \
        -e '/ lbmethod_bytraffic_module /s/^/#/' \
        -e '/ lbmethod_heartbeat_module /s/^/#/' \
        -e '/ proxy_balancer_module /s/^/#/' \
        -e '/ proxy_fdpass_module /s/^/#/' \
        -e '/ proxy_express_module /s/^/#/' \
        -e '/ proxy_scgi_module /s/^/#/' \
        /etc/httpd/conf.modules.d/00-proxy.conf \
    && sed -i -e '/ModPagespeedRespectVary /s/#//' \
        /etc/httpd/conf.d/pagespeed.conf 2>/dev/null \
    && sh /etc/cron.daily/mod-pagespeed \
    && chmod -v +x /usr/bin/run-httpd.sh

EXPOSE 80 443

COPY mpm_event_module.conf /etc/httpd/conf.d/mpm_event_module.conf
COPY security.conf /etc/httpd/conf.d/security.conf
COPY xtraparams.conf /etc/httpd/conf.d/xtraparams.conf

CMD ["/usr/bin/run-httpd.sh"]
