#!/bin/bash

printf "Launching FTP server..."

FTP_USER=$(cat /run/secrets/ftp_credentials | sed -n 1p | tr -d '\r')
FTP_PASSWORD=$(cat /run/secrets/ftp_credentials | sed -n 2p | tr -d '\r')

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
fi

chmod 600 /etc/ssl/private/vsftpd.pem
chown root:root /etc/ssl/private/vsftpd.pem

mkdir -p /var/run/vsftpd/empty

chown -R "$FTP_USER:$FTP_USER" /var/www/html
chmod -R 775 /var/www/html

exec "$@"