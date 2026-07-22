FROM debian:oldstable

WORKDIR /

ARG GRAFANA_VERSION=13.1.1

RUN apt update \
    && apt install -y --no-install-recommends ca-certificates \
    curl tar adduser libfontconfig1 \
    && rm -rf /var/lib/apt/lists/* \
    && adduser --system --group --home /var/lib/grafana grafana \
    && mkdir -p /usr/share/grafana /etc/grafana /var/lib/grafana /var/log/grafana \
    && curl -fsSL "https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz" \
    -o /tmp/grafana.tar.gz \
    && tar -xvzf /tmp/grafana.tar.gz -C /tmp \
    && cp -a "/tmp/grafana-${GRAFANA_VERSION}/." /usr/share/grafana/ \
    && chown -R grafana:grafana /usr/share/grafana /etc/grafana /var/lib/grafana /var/log/grafana \
    && rm -rf /tmp/grafana*
    
##    && cp -a /tmp/grafana-v${GRAFANA_VERSION}/* /usr/share/grafana/ \
COPY conf/grafana.ini /etc/grafana/grafana.ini

COPY conf/provisioning /etc/grafana/provisioning

COPY tools/entrypoint.sh .

RUN chmod +x entrypoint.sh \
    && chown grafana:grafana /entrypoint.sh /etc/grafana/grafana.ini

EXPOSE 3000

USER grafana

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "/usr/share/grafana/bin/grafana", \
    "server", \
    "--homepath=/usr/share/grafana", \
    "--config=/etc/grafana/grafana.ini", \
    "cfg:default.paths.data=/var/lib/grafana", \
    "cfg.default.paths.logs=/var/log/grafana", \
    "cfg:default.paths.plugins=/var/lib/grafana/plugins" ]