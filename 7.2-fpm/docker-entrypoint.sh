#!/bin/bash

sed -i -e "s/\$ENV_FPM_USER/${FPM_USER}/g" /usr/local/etc/php-fpm.d/www.conf
sed -i -e "s/\$ENV_FPM_GROUP/${FPM_GROUP}/g" /usr/local/etc/php-fpm.d/www.conf
sed -i -e "s/\$ENV_FPM_HOST/${FPM_HOST}/g" /usr/local/etc/php-fpm.d/www.conf
sed -i -e "s/\$ENV_FPM_PORT/${FPM_PORT}/g" /usr/local/etc/php-fpm.d/www.conf

php-fpm