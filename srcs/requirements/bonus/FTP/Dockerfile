FROM debian:bookworm

WORKDIR /

RUN apt update -y \
    && apt install -y openssl vsftpd tini \
    && rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/entrypoint.sh .

RUN chmod +x entrypoint.sh

ENTRYPOINT [ "/usr/bin/tini", "--", "/entrypoint.sh" ]

CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd.conf" ]