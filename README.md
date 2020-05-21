# PHP


`akibawolf/php` packages recent versions of PHP using Debian as the base image.

## Supported tags and respective `Dockerfile` links

- [`7.0-cli` (*Dockerfile*)](https://github.com/AkibaWolf/docker-php/tree/master/7.0-cli/Dockerfile)
- [`7.0-fpm` (*Dockerfile*)](https://github.com/AkibaWolf/docker-php/tree/master/7.0-fpm/Dockerfile)
- [`7.1-cli` (*Dockerfile*)](https://github.com/AkibaWolf/docker-php/tree/master/7.1-cli/Dockerfile)
- [`7.1-fpm` (*Dockerfile*)](https://github.com/AkibaWolf/docker-php/tree/master/7.1-fpm/Dockerfile)
- [`7.2-cli` (*Dockerfile*)](https://github.com/AkibaWolf/docker-php/tree/master/7.2-cli/Dockerfile)
- [`7.2-fpm` (*Dockerfile*)](https://github.com/AkibaWolf/docker-php/tree/master/7.2-fpm/Dockerfile)
- [`7.3-cli` (*Dockerfile*)](https://github.com/AkibaWolf/docker-php/tree/master/7.3-cli/Dockerfile)
- [`7.3-fpm` (*Dockerfile*)](https://github.com/AkibaWolf/docker-php/tree/master/7.3-fpm/Dockerfile)
- [`7.4-cli`, `latest` (*Dockerfile*)](https://github.com/AkibaWolf/docker-php/tree/master/7.4-cli/Dockerfile)
- [`7.4-fpm` (*Dockerfile*)](https://github.com/AkibaWolf/docker-php/tree/master/7.4-fpm/Dockerfile)

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

- `bcmath`
- `gd`
- `gearman`
- `geoip`
- `imagick`
- `intl`
- `mbstring`
- `mcrypt`
- `memcached`
- `mysqli`
- `opcache`
- `pdo_mysql`
- `redis`

## Usage

CLI shell:

```bash
docker run --rm -it akibawolf/php:latest bash
```

## Configuration defaults

| Name                   | Value                             |
| ---------------------- | --------------------------------- |
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

| Name      | Default value |
| --------- | ------------- |
| FPM_USER  | www-data      |
| FPM_GROUP | www-data      |
| FPM_HOST  | 0.0.0.0       |
| FPM_PORT  | 9000          |

You can also inject your version of php.ini file to `/usr/local/etc/php/php.ini` as needed.
