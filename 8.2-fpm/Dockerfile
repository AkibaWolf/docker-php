FROM php:8.2-fpm-bullseye

# Set environment variables
ENV USER_LOGIN user
ENV USER_UID 1000
ENV USER_GID 1000
ENV USER_SHELL /bin/bash

ENV GEOIP_VERSION 1.3.0
ENV MCRYPT_VERSION 1.0.4
ENV MEMCACHED_VERSION 3.1.5
ENV PHPREDIS_VERSION 5.3.7

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
        --with-freetype=/usr/include/ \
        --with-jpeg=/usr/include/ \
    && docker-php-ext-install gd \
    \
    && echo "### Install packages required for accessing GeoIP2 with PHP" \
    \
    && apt-get install -y \
        libgeoip-dev \
    \
    && echo "### Install Gearman PHP extension" \
    \
    && apt-get install -y \
        libgearman-dev \
    && cd /tmp \
    && git clone https://github.com/php/pecl-networking-gearman.git \
    && cd pecl-networking-gearman \
    && phpize \
    && ./configure \
    && make \ 
    && make install \
    && rm -rf /tmp/pecl-networking-gearman \
    && docker-php-ext-enable gearman.so \
    \
    && echo "### Install GeoIP PHP extension" \
    \
    && apt-get install -y \
        libgeoip-dev \
    && cd /tmp \
    && docker-php-source extract \
    && curl -L -o geoip.tgz https://github.com/rlerdorf/geoip/archive/refs/tags/$GEOIP_VERSION.tar.gz \
    && mkdir geoip \
    && tar xfz geoip.tgz -C geoip --strip-components 1 \
    && rm -r geoip.tgz \
    && mv geoip /usr/src/php/ext/geoip \
    && docker-php-ext-install -j$(nproc) geoip \
    && docker-php-source delete \
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
    && cd /tmp \
    && wget https://pecl.php.net/get/mcrypt-$MCRYPT_VERSION.tgz \
    && tar -xf mcrypt-$MCRYPT_VERSION.tgz \
    && cd mcrypt-$MCRYPT_VERSION \
    && phpize \
    && ./configure \
    && make \
    && wget https://github.com/php/pecl-encryption-mcrypt/commit/5b16bf1c97c1bbab400fc877285bf0919ae73256.diff \
    && git apply 5b16bf1c97c1bbab400fc877285bf0919ae73256.diff \
    && make test \
    && cp modules/*.so $(pecl config-get ext_dir) \
    && cd .. \
    && rm -rf mcrypt-$MCRYPT_VERSION.tgz mcrypt-$MCRYPT_VERSION \
    && docker-php-ext-enable mcrypt \
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
    && echo "### Install PDO PgSQL PHP extension" \
    \
    && apt-get install -y \
        libpq-dev \
    && docker-php-ext-install pdo_pgsql \
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
