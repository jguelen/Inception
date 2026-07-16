FROM debian:oldstable

WORKDIR /

RUN apt update -y \
    && apt install -y openssl vsftpd \
    && rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/entrypoint.sh .

RUN chmod +x entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd.conf" ]