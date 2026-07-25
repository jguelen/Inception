FROM debian:bookworm

WORKDIR /

ARG CADVISOR_VERSION=v0.60.5

RUN apt update && apt install -y ca-certificates curl \
    &&  rm -rf /var/lib/apt/lists/* \
    && curl -fsSL "https://github.com/google/cadvisor/releases/download/${CADVISOR_VERSION}/cadvisor-${CADVISOR_VERSION}-linux-amd64" \
    -o /usr/local/bin/cadvisor \
    && chmod +x /usr/local/bin/cadvisor

COPY tools/entrypoint.sh .

RUN chmod +x entrypoint.sh

EXPOSE 8080

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "/usr/local/bin/cadvisor", "--port=8080", "--logtostderr" ]