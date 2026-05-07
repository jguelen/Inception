FROM debian:oldstable

WORKDIR /

RUN apt update && apt install -y mariadb-server mariadb-client \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /etc/mysql/mariadb.conf.d

COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/mariadb.cnf
COPY tools/entrypoint.sh .

RUN chmod +x entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "entrypoint.sh" ]

CMD [ "mariadbd-safe", "--defaults-file=/etc/mysql/mariadb.conf/mariadb.cnf" ]