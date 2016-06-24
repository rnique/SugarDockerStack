In linux, create log files before starting docker-compose.
Make them writeable for user that writes on them and runs under Docker container (apache, etc.).
For example:
touch apache.log cron.log php-fpm-error.log
