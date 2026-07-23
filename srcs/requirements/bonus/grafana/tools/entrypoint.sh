#!/bin/bash

set -e

printf "Launching Grafana...\n"

#chown -R grafana:grafana /usr/share/grafana /etc/grafana /var/lib/grafana /var/log/grafana

exec "$@"
