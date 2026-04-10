FROM debian:oldstable

RUN apt update --no-cache && apt install -y --no-cache nginx openssl
#    && rm -f /etc/nginx/default.conf \

RUN openssl req -x509 \
                    -noenc \
                    -days 365 \
                    -out /etc/nginx/ssl/inception.crt \
                    -keyout /etc/nginx/ssl/inception.key \
                    -subj "/C=FR/ST=normandy/L=Le Havre/O=42LH/CN=jguelen.42.fr" \
                    -addext "subjectAltName=DNS:jguelen.42.fr,DNS:localhost"

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
#/var/lib/apt/lists