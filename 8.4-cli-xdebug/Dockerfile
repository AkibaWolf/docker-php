FROM akibawolf/php:8.4-cli AS php-base

# Set environment variables
ENV PHP_IDE_CONFIG="serverName=localhost"

# --------------------------------------------------------------------------------------

FROM php-base AS php-xdebug-base

# Install Xdebug PHP extension
RUN install-php-extensions xdebug

# --------------------------------------------------------------------------------------

FROM php-xdebug-base AS php-app-base

# Copy configuration files
COPY config/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

