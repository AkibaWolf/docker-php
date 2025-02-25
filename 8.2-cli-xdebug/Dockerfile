FROM akibawolf/php:8.2-cli AS php-base

# Set environment variables
ENV PHP_IDE_CONFIG="serverName=localhost"

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

