# PHP

`akibawolf/php` packages recent versions of PHP using Debian as the base image.

## Supported tags and respective `Dockerfile` links

- [`8.4-cli`, `cli-latest`, `latest` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.4-cli/Dockerfile)
- [`8.4-cli-xdebug` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.4-cli-xdebug/Dockerfile)
- [`8.4-fpm`, `fpm-latest` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.4-fpm/Dockerfile)
- [`8.4-fpm-xdebug` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.4-fpm-xdebug/Dockerfile)
- [`8.3-cli` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.3-cli/Dockerfile)
- [`8.3-cli-xdebug` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.3-cli-xdebug/Dockerfile)
- [`8.3-fpm` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.3-fpm/Dockerfile)
- [`8.3-fpm-xdebug` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.3-fpm-xdebug/Dockerfile)
- [`8.2-cli` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.2-cli/Dockerfile)
- [`8.2-cli-xdebug` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.2-cli-xdebug/Dockerfile)
- [`8.2-fpm` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.2-fpm/Dockerfile)
- [`8.2-fpm-xdebug` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.2-fpm-xdebug/Dockerfile)
- [`8.1-cli` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.1-cli/Dockerfile)
- [`8.1-fpm` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.1-fpm/Dockerfile)
- [`8.0-cli` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.0-cli/Dockerfile)
- [`8.0-fpm` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/8.0-fpm/Dockerfile)
- [`7.4-cli` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/7.4-cli/Dockerfile)
- [`7.4-fpm` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/7.4-fpm/Dockerfile)
- [`7.3-cli` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/7.3-cli/Dockerfile)
- [`7.3-fpm` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/7.3-fpm/Dockerfile)
- [`7.2-cli` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/7.2-cli/Dockerfile)
- [`7.2-fpm` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/7.2-fpm/Dockerfile)
- [`7.1-cli` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/7.1-cli/Dockerfile)
- [`7.1-fpm` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/7.1-fpm/Dockerfile)
- [`7.0-cli` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/7.0-cli/Dockerfile)
- [`7.0-fpm` (_Dockerfile_)](https://github.com/AkibaWolf/docker-php/tree/master/7.0-fpm/Dockerfile)

Base images used:

- `php-stretch` for 7.0
- `php-buster` for 7.1 and 7.2
- `php-bullseye` for 7.3 and newer

## Pre-installed packages

- `curl`
- `git`
- `ping`
- `mc`
- `nano`
- `supervisor`
- `unzip`
- `vim`
- `wget`

## Pre-configured extensions

- `apcu` (for PHP >= 8.2.0)
- `bcmath`
- `gd`
- `gearman`
- `geoip` (for PHP < 8.4.0)
- `imagick`
- `intl`
- `mbstring`
- `mcrypt` (for PHP < 8.4.0)
- `memcached`
- `mysqli`
- `opcache`
- `pcntl` (for PHP >= 8.2.0)
- `pdo_mysql`
- `pdo_pgsql`
- `redis`
- `sockets` (for PHP >= 8.2.0)
- `xdebug` (for images with `xdebug` suffix)
- `xml` (for PHP >= 8.2.0)
- `xsl` (for PHP >= 8.2.0)
- `zip` (for PHP >= 8.2.0)

## Usage

CLI shell:

```bash
docker run --rm -it akibawolf/php:cli-latest bash
```

FPM:

```bash
docker run --rm -v /app:/app --env FPM_PORT=9001 --expose 9001 akibawolf/php:fpm-latest
```

Docker compose:

```
php:
  image: akibawolf/php:fpm-latest
  container_name: project_php
  working_dir: /app/project
  environment:
    FPM_PORT: 9001
  volumes:
    - ./web/project:/app/web/project
  networks:
    - default
  expose:
    - 9001
```

## Configuration defaults

| Name                   | Value                             |
|------------------------|-----------------------------------|
| short_open_tag         | Off                               |
| implicit_flush         | Off                               |
| max_execution_time     | 30                                |
| max_input_time         | 60                                |
| memory_limit           | 128M                              |
| error_reporting        | E_ALL & ~E_DEPRECATED & ~E_STRICT |
| display_errors         | On                                |
| display_startup_errors | Off                               |
| log_errors             | On                                |
| error_log              | /dev/stderr                       |
| post_max_size          | 140M                              |
| default_mimetype       | text/html                         |
| default_charset        | UTF-8                             |
| file_uploads           | On                                |
| upload_max_filesize    | 128M                              |
| max_file_uploads       | 20                                |
| date.timezone          | Asia/Tashkent                     |

## FPM environment variables

| Name                    | Default value |
|-------------------------|---------------|
| FPM_USER                | www-data      |
| FPM_GROUP               | www-data      |
| FPM_HOST                | 0.0.0.0       |
| FPM_PORT                | 9000          |
| PHP_MEMORY_LIMIT \*     | 128M          |
| PHP_POST_MAX_SIZE       | 140M          |
| PHP_UPLOAD_MAX_FILESIZE | 128M          |

_\* Available in images that provide PHP 7.1 and higher._

## Xdebug environment variables

| Name                      | Default value        |
|---------------------------|----------------------|
| PHP_IDE_CONFIG            | serverName=localhost |
| XDEBUG_CLIENT_HOST        | host.docker.internal |
| XDEBUG_CLIENT_PORT        | 9003                 |
| XDEBUG_IDE_KEY            | PHPSTORM             |
| XDEBUG_START_WITH_REQUEST | yes                  |

_Available in FPM Xdebug images._

## Configuration

You can also inject your version of configuration files as needed:

- `/usr/local/etc/php/php.ini`
- `/usr/local/etc/php-fpm.conf`
- `/usr/local/etc/php-fpm.d/www.conf`
- `/etc/supervisor/conf.d/supervisord.conf`
- `/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini`
