#!/bin/bash
set -eo pipefail

cd /etc
sed -i -e '/^error_log/s/^/error_log=${PHP_FPM_ERROR_LOG} ;/' \
        -e '/^php_value[session.save_handler]/s/^/php_value[session.save_handler] = ${PHP_SESSION_SAVE_HANDLER} ;/' \
        -e '/^php_value[session.save_path]/s/^/php_value[session.save_path] = ${PHP_SESSION_SAVE_PATH} ;/' php-fpm.conf

exec php-fpm
