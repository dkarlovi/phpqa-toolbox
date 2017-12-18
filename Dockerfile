FROM jakzal/phpqa:alpine

ENV BUILD_DEPS="autoconf file g++ gcc libc-dev make pkgconf re2c unzip"
ENV LIB_DEPS="cyrus-sasl-dev icu-dev gmp-dev libmemcached-dev libpng-dev openldap-dev postgresql-dev"

RUN apk add --no-cache --virtual .tool-deps $LIB_DEPS && \
    apk add --no-cache --virtual .build-deps $BUILD_DEPS && \
    docker-php-ext-install gd gmp intl ldap mysqli opcache pcntl pgsql && \
    pecl install apcu igbinary memcached mongodb redis && \
    docker-php-ext-enable apcu igbinary memcached mongodb redis && \
    apk del .build-deps
