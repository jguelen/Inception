FROM debian:oldstable

WORKDIR /

ARG PROM_VERSION=3.5.5

RUN apt update && apt install -y curl tar \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fssL "https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz" \
    -o /tmp/prometheus.tar.gz \
    && tar xvfz /tmp/prometheus.tar.gz -C /tmp \
    && mv "/tmp/prometheus-${PROM_VERSION}.linux-amd64/prometheus" /usr/local/bin/prometheus \
    && mv "/tmp/prometheus-${PROM_VERSION}.linux-amd64/promtool" /usr/local/bin/promtool \
    && mkdir -p /etc/prometheus /prometheus \
    && rm -rf /tmp/prometheus*

COPY tools/entrypoint.sh .

COPY conf/prometheus.yml /etc/prometheus/prometheus.yml

RUN chmod +x entrypoint.sh

EXPOSE 9090

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "prometheus", "--config.file=/etc/prometheus/prometheus.yml", "--storage.tsdb.path=/prometheus" ]