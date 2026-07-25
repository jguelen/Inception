FROM debian:bookworm

WORKDIR /

ARG EXPORTER_VERSION=1.12.1

RUN apt update \
    && apt install -y --no-install-recommends ca-certificates curl tar \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL "https://github.com/prometheus/node_exporter/releases/download/v${EXPORTER_VERSION}/node_exporter-${EXPORTER_VERSION}.linux-amd64.tar.gz" -o /tmp/node_exporter.tar.gz \
    && tar -xzf /tmp/node_exporter.tar.gz -C /tmp \
    && cp "/tmp/node_exporter-${EXPORTER_VERSION}.linux-amd64/node_exporter" /usr/local/bin/node_exporter \
    && chmod +x /usr/local/bin/node_exporter \
    && rm -rf /tmp/node_exporter*

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9100

ENTRYPOINT ["/entrypoint.sh"]
# The --path.rootfs flag is essential when running inside a container to view host metrics
CMD ["/usr/local/bin/node_exporter", "--path.rootfs=/host"]