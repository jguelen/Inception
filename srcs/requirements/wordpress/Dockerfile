FROM debian:oldstable

WORKDIR /

RUN apt update \
    && apt install -y \
    curl \
    php php8.2-fpm php-mysql php-curl \
    php-gd php-intl php-mbstring php-soap php-xml \
    php-xmlrpc php-zip \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/log/php /var/run/php

RUN curl -O \
    https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY tools/* .

RUN chmod +x wp_entrypoint.sh

ENTRYPOINT [ "wp_entrypoint.sh" ]
