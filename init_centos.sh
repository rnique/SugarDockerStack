#!/bin/bash

touch ./log/apache.log ./log/cron.log ./log/php-fpm-error.log
chown 48:48 ./log/*.log
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo 'vm.overcommit_memory=1' >> /etc/sysctl.conf
sysctl vm.overcommit_memory=1
echo 'net.core.somaxconn=1024' >> /etc/sysctl.conf
sysctl -w net.core.somaxconn=1024

