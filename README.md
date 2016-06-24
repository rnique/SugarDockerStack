# Sugar Docker Stack
Dockerfiles organized as Docker Compose App configured to run SugarCRM 7.7

Base image: Centos:7

Includes the following:
- Apache 2.4.x (latest in epel)
- PHP 5.5.x (latest)
- Redis
- Elasticsearch 1.4.4
- Percona Server (Mysql 5.7)
- Crontab + Rsyslog (runs in a separate docker container)
