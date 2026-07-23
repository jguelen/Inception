FROM debian:oldstable

WORKDIR /

ARG EXPORTER_VERSION=0.15.1

RUN apt update \
    && apt install -y --no-install-recommends ca-certificates curl tar \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL "https://github.com/prometheus/mysqld_exporter/releases/download/v${EXPORTER_VERSION}/mysqld_exporter-${EXPORTER_VERSION}.linux-amd64.tar.gz" -o /tmp/mysqld_exporter.tar.gz \
    && tar -xzf /tmp/mysqld_exporter.tar.gz -C /tmp \
    && cp "/tmp/mysqld_exporter-${EXPORTER_VERSION}.linux-amd64/mysqld_exporter" /usr/local/bin/mysqld_exporter \
    && chmod +x /usr/local/bin/mysqld_exporter \
    && rm -rf /tmp/mysqld_exporter*

COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 9104

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/local/bin/mysqld_exporter", "--config.my-cnf=/etc/mysqld-exporter/.my.cnf"]