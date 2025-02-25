FROM akibawolf/php:8.3-fpm AS php-base

# Set environment variables
ENV PHP_IDE_CONFIG="serverName=localhost"

ENV XDEBUG_CLIENT_HOST=host.docker.internal
ENV XDEBUG_CLIENT_PORT=9003
ENV XDEBUG_IDE_KEY=PHPSTORM
ENV XDEBUG_START_WITH_REQUEST=yes

# --------------------------------------------------------------------------------------

FROM php-base AS php-extensions-installer-base

# Setup PHP extensions installer
RUN curl -sSLf \
    -o /usr/local/bin/install-php-extensions \
    https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
    && chmod +x /usr/local/bin/install-php-extensions

# --------------------------------------------------------------------------------------

FROM php-extensions-installer-base AS php-xdebug-base

# Install Xdebug PHP extension
RUN install-php-extensions xdebug

# --------------------------------------------------------------------------------------

FROM php-xdebug-base AS php-app-base

# Copy configuration files
COPY config/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Configure entry point
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
