#FROM alpine:3.19
#
#WORKDIR /
#
## Install vsftpd, openssl, bash, and shadow (for useradd/chpasswd)
#RUN apk update && apk upgrade && \
#    apk add --no-cache vsftpd openssl bash shadow
#
#COPY conf/vsftpd.conf /etc/vsftpd.conf
#COPY tools/entrypoint.sh /entrypoint.sh
#
#RUN chmod +x /entrypoint.sh
#
#ENTRYPOINT [ "/entrypoint.sh" ]
#
#CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd.conf" ]

## FROM debian:oldstable
## 
## WORKDIR /
## 
## RUN apt update -y \
##     && apt install -y openssl vsftpd \
##     && rm -rf /var/lib/apt/lists/*
## 
## COPY conf/vsftpd.conf /etc/vsftpd.conf
## COPY tools/entrypoint.sh .
## 
## RUN chmod +x entrypoint.sh
## 
## ENTRYPOINT [ "/entrypoint.sh" ]
## 
## CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd.conf" ]

FROM debian:oldoldstable

RUN apt-get update && \
    apt-get install -y \
    vsftpd \
    ftp \
    openssl && \
    rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]