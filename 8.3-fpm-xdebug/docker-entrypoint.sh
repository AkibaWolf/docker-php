#!/bin/bash

sed -i -e "s/\$ENV_PHP_MEMORY_LIMIT/${PHP_MEMORY_LIMIT}/g" /usr/local/etc/php/php.ini
sed -i -e "s/\$ENV_PHP_POST_MAX_SIZE/${PHP_POST_MAX_SIZE}/g" /usr/local/etc/php/php.ini
sed -i -e "s/\$ENV_PHP_UPLOAD_MAX_FILESIZE/${PHP_UPLOAD_MAX_FILESIZE}/g" /usr/local/etc/php/php.ini

sed -i -e "s/\$ENV_FPM_USER/${FPM_USER}/g" /usr/local/etc/php-fpm.d/www.conf
sed -i -e "s/\$ENV_FPM_GROUP/${FPM_GROUP}/g" /usr/local/etc/php-fpm.d/www.conf
sed -i -e "s/\$ENV_FPM_HOST/${FPM_HOST}/g" /usr/local/etc/php-fpm.d/www.conf
sed -i -e "s/\$ENV_FPM_PORT/${FPM_PORT}/g" /usr/local/etc/php-fpm.d/www.conf

sed -i -e "s/\$ENV_XDEBUG_START_WITH_REQUEST/${XDEBUG_START_WITH_REQUEST}/g" /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
sed -i -e "s/\$ENV_XDEBUG_CLIENT_HOST/${XDEBUG_CLIENT_HOST}/g" /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
sed -i -e "s/\$ENV_XDEBUG_CLIENT_PORT/${XDEBUG_CLIENT_PORT}/g" /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
sed -i -e "s/\$ENV_XDEBUG_IDE_KEY/${XDEBUG_IDE_KEY}/g" /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

supervisord
