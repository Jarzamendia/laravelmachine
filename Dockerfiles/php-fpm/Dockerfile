FROM php:7.3.1-fpm-alpine3.9

#REMOVE!
ENV http_proxy=http://proxy.sgi.ms.gov.br:8081
ENV https_proxy=http://proxy.sgi.ms.gov.br:8081
ENV no_proxy="localhost,127.0.0.1"

RUN apk update && \
    apk add --no-cache git \
            grep \
            libmemcached-dev \
            libmcrypt-dev \
            libxml2-dev \
            imagemagick-dev \
            pcre-dev \
            libtool \
            autoconf \
            g++ \
            cyrus-sasl-dev \
            libgsasl-dev \
            make \
            shadow 

RUN docker-php-ext-install mysqli mbstring pdo pdo_mysql tokenizer xml
RUN pear config-set http_proxy proxy.sgi.ms.gov.br:8081

RUN pecl channel-update pecl.php.net \
    && pecl install memcached \
    && pecl install imagick \
    && pecl install mcrypt-1.0.2 \
    && pecl install -o -f redis \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable memcached \
    && docker-php-ext-enable imagick \
    && docker-php-ext-enable mcrypt

COPY ./laravel.ini /usr/local/etc/php/conf.d
COPY ./xlaravel.pool.conf /usr/local/etc/php-fpm.d/

RUN rm /var/cache/apk/*

RUN usermod -u 1000 www-data

WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9000