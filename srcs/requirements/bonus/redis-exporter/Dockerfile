FROM debian:oldstable

WORKDIR /

ARG EXPORTER_VERSION=1.58.0

RUN apt update \
    && apt install -y --no-install-recommends ca-certificates curl tar \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL "https://github.com/oliver006/redis_exporter/releases/download/v${EXPORTER_VERSION}/redis_exporter-v${EXPORTER_VERSION}.linux-amd64.tar.gz" -o /tmp/redis_exporter.tar.gz \
    && tar -xzf /tmp/redis_exporter.tar.gz -C /tmp \
    && cp "/tmp/redis_exporter-v${EXPORTER_VERSION}.linux-amd64/redis_exporter" /usr/local/bin/redis_exporter \
    && chmod +x /usr/local/bin/redis_exporter \
    && rm -rf /tmp/redis_exporter*

COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 9121

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/local/bin/redis_exporter", "-redis.addr", "redis://redis:6379"]