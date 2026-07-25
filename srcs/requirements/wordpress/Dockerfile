FROM debian:bookworm

WORKDIR /

RUN apt update \
    && apt install -y \
    curl \
    php php-mysql php-curl \
    php-gd php-intl php-mbstring php-soap php-xml \
    php-xmlrpc php-zip php8.2-fpm\
    mariadb-client \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/log/php /var/run/php

RUN curl -O \
    https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY tools/* .
COPY conf/php-fpm8.2.conf /etc/php/8.2/fpm/pool.d/www.conf


RUN chmod +x entrypoint.sh wp_init.sh \
    && chmod 644 /etc/php/8.2/fpm/pool.d/www.conf

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "/usr/sbin/php-fpm8.2", "-F" ]
