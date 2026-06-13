#!/bin/bash

envsubst '${DOMAIN_NAME}' < /etc/nginx/nginx.conf

exec "$@"