FROM php:8.4.4-cli-bookworm AS os-base

# Set environment variables
ENV USER_LOGIN=user
ENV USER_UID=1000
ENV USER_GID=1000
ENV USER_SHELL=/bin/bash

ENV MEMCACHED_VERSION=3.3.0
ENV PHPREDIS_VERSION=6.1.0

# Create user & group
RUN groupadd -g $USER_GID -o $USER_LOGIN
RUN useradd -m -u $USER_UID -g $USER_GID -o -s $USER_SHELL $USER_LOGIN

# Install base packages
RUN apt update
RUN apt upgrade -y
RUN apt install -y --no-install-recommends \
    curl \
    git \
    inetutils-ping \
    libfreetype6-dev \
    libgearman-dev \
    libgif-dev \
    libicu-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libmagickwand-dev \
    libmemcached-dev \
    libonig-dev \
    libpng-dev \
    libpq-dev \
    libssl-dev \
    libwebp-dev \
    libxslt-dev \
    libzip-dev \
    mc \
    nano \
    net-tools \
    pkg-config \
    procps \
    supervisor \
    unzip \
    vim \
    wget \
    zip \
    zlib1g-dev

# --------------------------------------------------------------------------------------

FROM os-base AS php-extensions-installer-base

# Setup PHP extensions installer
RUN curl -sSLf \
    -o /usr/local/bin/install-php-extensions \
    https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
    && chmod +x /usr/local/bin/install-php-extensions

# --------------------------------------------------------------------------------------

FROM php-extensions-installer-base AS php-apcu-base

# Install APCu PHP extension
RUN pecl install apcu \
    && docker-php-ext-enable apcu

# --------------------------------------------------------------------------------------

FROM php-apcu-base AS php-bcmath-base

# Install BC Math PHP extension
RUN docker-php-ext-install bcmath

# --------------------------------------------------------------------------------------

FROM php-bcmath-base AS php-gd-base

# Install GD PHP extension
# Required packages:
#  - libfreetype6-dev
#  - libgif-dev
#  - libicu-dev
#  - libjpeg-dev
#  - libjpeg62-turbo-dev
#  - libpng-dev
#  - libwebp-dev
#  - zlib1g-dev
RUN docker-php-ext-configure gd \
    --with-freetype=/usr/include/ \
    --with-jpeg=/usr/include/ \
    --with-webp=/usr/include/
RUN docker-php-ext-install gd

# --------------------------------------------------------------------------------------

FROM php-gd-base AS php-gearman-base

# Install Gearman PHP extension
# Required packages:
#  - libgearman-dev
RUN cd /tmp \
    && git clone https://github.com/php/pecl-networking-gearman.git \
    && cd pecl-networking-gearman \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && rm -rf /tmp/pecl-networking-gearman \
    && docker-php-ext-enable gearman.so

# --------------------------------------------------------------------------------------

FROM php-gearman-base AS php-imagemagick-base

# Install ImageMagick PHP extension
# Required packages:
#  - libmagickwand-dev
RUN install-php-extensions imagick

# --------------------------------------------------------------------------------------

FROM php-imagemagick-base AS php-intl-base

# Install Intl PHP extension
RUN docker-php-ext-configure intl \
    && docker-php-ext-install intl

# --------------------------------------------------------------------------------------

FROM php-intl-base AS php-mbstring-base

# Install MBString (Multibyte String) PHP extension
RUN docker-php-ext-install mbstring

# --------------------------------------------------------------------------------------

FROM php-mbstring-base AS php-memcached-base

# Install Memcached PHP extension
# Required packages:
#  - libmemcached-dev
RUN cd /tmp \
    && git clone https://github.com/php-memcached-dev/php-memcached.git \
    && cd php-memcached/ \
    && git checkout tags/v$MEMCACHED_VERSION \
    && phpize \
    && ./configure --enable-memcached-json \
    && make \
    && make install \
    && docker-php-ext-enable memcached

# --------------------------------------------------------------------------------------

FROM php-memcached-base AS php-mysqli-base

# Install MySQLi PHP extension
RUN docker-php-ext-install mysqli

# --------------------------------------------------------------------------------------

FROM php-mysqli-base AS php-opcache-base

# Install OPcache PHP extension
RUN docker-php-ext-install opcache

# --------------------------------------------------------------------------------------

FROM php-opcache-base AS php-pdo-mysql-base

# Install PDO MySQL PHP extension
RUN docker-php-ext-install pdo_mysql

# --------------------------------------------------------------------------------------

FROM php-pdo-mysql-base AS php-pdo-pgsql-base

# Install PDO PgSQL PHP extension
# Required packages:
#  - libpq-dev
RUN docker-php-ext-install pdo_pgsql

# --------------------------------------------------------------------------------------

FROM php-pdo-pgsql-base AS php-redis-base

# Install Redis PHP extension
RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz | \
    tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis \
    && rm -rf /usr/src/php/ext/redis

# --------------------------------------------------------------------------------------

FROM php-redis-base AS php-pcntl-base

# Install PCNTL PHP extension
RUN docker-php-ext-install pcntl \
    && docker-php-ext-configure pcntl --enable-pcntl

# --------------------------------------------------------------------------------------

FROM php-pcntl-base AS php-sockets-base

# Install Sockets PHP extension
RUN docker-php-ext-install sockets

# --------------------------------------------------------------------------------------

FROM php-sockets-base AS php-xml-base

# Install XML PHP extension
RUN docker-php-ext-install xml

# --------------------------------------------------------------------------------------

FROM php-xml-base AS php-xsl-base

# Install XSL PHP extension
# Required packages:
#  - libxslt-dev
RUN docker-php-ext-install xsl \
    && docker-php-ext-enable xsl

# --------------------------------------------------------------------------------------

FROM php-xsl-base AS php-zip-base

# Install Zip PHP extension
# Required packages:
#  - libzip-dev
RUN docker-php-ext-install zip

# --------------------------------------------------------------------------------------

FROM php-zip-base AS php-app-base

# Copy configuration files
COPY config/php.ini /usr/local/etc/php/php.ini

# Declare volumes
VOLUME ["/app"]

# Set working directory
WORKDIR /app
