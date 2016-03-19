#!/bin/bash

chown -R grafana:grafana /var/lib/grafana /var/log/grafana

if [ ! -d "/var/lib/grafana/plugins/" ]; then
  mkdir -p /var/lib/grafana/plugins/
  cp -r /usr/share/grafana-plugins/* /var/lib/grafana/plugins/
fi

exec gosu grafana /usr/sbin/grafana-server \
  --homepath=/usr/share/grafana            \
  --config=/etc/grafana/grafana.ini        \
  cfg:default.paths.data=/var/lib/grafana  \
  cfg:default.paths.logs=/var/log/grafana  \
  cfg:default.paths.plugins=/var/lib/grafana/plugins
