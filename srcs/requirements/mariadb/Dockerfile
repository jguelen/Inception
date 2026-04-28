FROM debian:oldstable

WORKDIR /

RUN apt update && apt install -y mariadb-server mariadb-client

COPY conf/mariadb.cnf /etc/mysql/mariadb.cnf
COPY tools/entrypoint.sh .

EXPOSE 3306

ENTRYPOINT [ "entrypoint.sh" ]

# CMD [ "mysql" ]