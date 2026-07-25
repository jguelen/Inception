FROM debian:bookworm

WORKDIR /

RUN apt update -y \
    && apt install -y redis-server \
    && rm -rf /var/lib/apt/lists/*

COPY tools/entrypoint.sh .

RUN chmod +x entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "redis-server", \
    "--bind", "0.0.0.0", \
    "--port", "6379", \
    "--protected-mode", "no", \
    "--maxmemory", "256mb", \
    "--maxmemory-policy", "allkeys-lru"]