FROM php:7.0-fpm-stretch

# Set environment variables
ENV USER_LOGIN user
ENV USER_UID 1000
ENV USER_GID 1000
ENV USER_SHELL /bin/bash

ENV GEOIP_VERSION 1.1.1
ENV MEMCACHED_VERSION 3.1.5
ENV PHPREDIS_VERSION 5.2.2

ENV PHP_POST_MAX_SIZE 140M
ENV PHP_UPLOAD_MAX_FILESIZE 128M

ENV FPM_USER www-data
ENV FPM_GROUP www-data
ENV FPM_HOST 0.0.0.0
ENV FPM_PORT 9000

# Set up environment, build & install required packages
RUN echo "### Create user & group" \
    \
    && groupadd -g $USER_GID -o $USER_LOGIN \
    && useradd -m -u $USER_UID -g $USER_GID -o -s $USER_SHELL $USER_LOGIN \
    \
    && echo "### Install base packages" \
    \
    && apt-get update \
    && apt-get install -y \
        curl \
        git \
        inetutils-ping \
        libonig-dev \
        mc \
        nano \
        net-tools \
        pkg-config \
        procps \
        supervisor \
        unzip \
        vim \
        wget \
    \
    && echo "### Install BC Math PHP extension" \
    \
    && docker-php-ext-install bcmath \
    \
    && echo "### Install GD PHP extension" \
    \
    && apt-get install -y \
        libfreetype6-dev \
        libgif-dev \
        libicu-dev \
        libjpeg-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        zlib1g-dev \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    \
    && echo "### Install Gearman PHP extension" \
    \
    && apt-get install -y \
        libgearman-dev \
    && cd /tmp \
    && git clone https://github.com/wcgallego/pecl-gearman.git \
    && cd pecl-gearman \
    && phpize \
    && ./configure \
    && make \ 
    && make install \
    && rm -rf /tmp/pecl-gearman \
    && docker-php-ext-enable gearman.so \
    \
    && echo "### Install GeoIP PHP extension" \
    \
    && apt-get install -y \
        libgeoip-dev \
    && pecl install geoip-$GEOIP_VERSION \
    && docker-php-ext-enable geoip \
    \
    && echo "### Install ImageMagick PHP extension" \
    \
    && apt-get install -y \
        libmagickwand-dev \
        --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    \
    && echo "### Install Intl PHP extension" \
    \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    \
    && echo "### Install MBString (Multibyte String) PHP extension" \
    \
    && docker-php-ext-install mbstring \
    \
    && echo "### Install Mcrypt PHP extension" \
    \
    && apt-get install -y \
        libmcrypt-dev \
    && docker-php-ext-install mcrypt \
    \
    && echo "### Install Memcached PHP extension" \
    \
    && apt-get install -y \
        libmemcached-dev \
    && cd /tmp && git clone https://github.com/php-memcached-dev/php-memcached.git \
    && cd php-memcached/ \
    && git checkout tags/v$MEMCACHED_VERSION \
    && phpize \
    && ./configure \
        --enable-memcached-json \
    && make \
    && make install \
    && docker-php-ext-enable memcached \
    \
    && echo "### Install MySQLi PHP extension" \
    \
    && docker-php-ext-install mysqli \
    \
    && echo "### Install OPcache PHP extension" \
    \
    && docker-php-ext-install opcache \
    \
    && echo "### Install PDO MySQL PHP extension" \
    \
    && docker-php-ext-install pdo_mysql \
    \
    && echo "### Install Redis PHP extension" \
    \
    && mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz | \
    tar xvz -C /usr/src/php/ext/redis \
        --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis \
    && rm -rf /usr/src/php/ext/redis

# Copy configuration files
COPY config/php.ini /usr/local/etc/php/php.ini
COPY config/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY config/php-fpm.d/docker.conf /usr/local/etc/php-fpm.d/docker.conf
COPY config/php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY config/php-fpm.d/zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
COPY config/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Declare volumes
VOLUME ["/app"]

# Set working directory
WORKDIR /app

# Configure entry point
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
