FROM debian:bookworm

WORKDIR /

STOPSIGNAL SIGINT

RUN apt update \
    && apt install -y curl php php-mysql php-mbstring php-zip php-json php-curl \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/www/adminer

RUN curl -fsSL https://www.adminer.org/latest-mysql-en.php -o /var/www/adminer/index.php

COPY tools/entrypoint.sh .

RUN chmod +x entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "php", "-S", "0.0.0.0:3003", "-t", "/var/www/adminer" ]