FROM debian:oldstable

WORKDIR /

RUN apt update && apt install -y nginx \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f /etc/nginx/default.conf \
    && mkdir -p /var/www/static

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY tools/entrypoint.sh .

ADD src/* /var/www/static

RUN chmod +x entrypoint.sh

EXPOSE 5000

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "nginx", "-g", "daemon off;" ]