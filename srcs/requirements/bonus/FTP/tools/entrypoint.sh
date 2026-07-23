#!/bin/bash

printf "Launching FTP server..."

FTP_USER=$(cat /run/secrets/ftp_credentials | sed -n 1p)
FTP_PASSWORD=$(cat /run/secrets/ftp_credentials | sed -n 2p)

# Create user if missing
if ! id "$FTP_USER" >/dev/null 2>&1; then
  useradd -m -d /var/www/html -s /bin/bash "$FTP_USER"
fi

echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd

mkdir -p /etc/vsftpd

touch /etc/vsftpd/user_list

grep -qxF "$FTP_USER" /etc/vsftpd/user_list || echo "$FTP_USER" >> /etc/vsftpd/user_list

mkdir -p /etc/ssl/private
if [ ! -f /etc/ssl/private/vsftpd.pem ]; then
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/vsftpd.pem \
    -out /etc/ssl/private/vsftpd.pem \
    -subj "/C=FR/ST=Normandy/L=Le Havre/O=42/CN=jguelen.42.fr"
    chmod 600 /etc/ssl/private/vsftpd.pem
fi

exec "$@"