FROM debian:oldstable

WORKDIR /

COPY tools/entrypoint.sh .

RUN chmod +x entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]