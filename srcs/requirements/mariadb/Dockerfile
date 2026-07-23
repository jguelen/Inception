FROM debian:oldstable

WORKDIR /

STOPSIGNAL SIGINT

RUN apt update && apt install -y mariadb-server mariadb-client \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /etc/mysql/mariadb.conf.d /var/log/mysql /run/mysqld \
    && chmod 755 /var/log/mysql /run/mysqld

COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/mariadb.cnf
ADD tools/* .

RUN chmod +x entrypoint.sh database_init.sh

EXPOSE 3306

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "mariadbd-safe", \
"--defaults-file=/etc/mysql/mariadb.conf.d/mariadb.cnf", \
 "--user=mysql" ]