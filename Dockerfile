FROM debian:jessie
MAINTAINER Jan Garaj info@monitoringartist.com

# inbuilt datasources:
# cloudwatch elasticsearch grafana graphite influxdb mixed opentsdb prometheus
# sql kairosdb

ENV GRAFANA_VERSION 3.0.0-beta11459429091

COPY ./run.sh /run.sh

RUN \
  apt-get update && \
  apt-get -y --force-yes --no-install-recommends install libfontconfig curl ca-certificates git jq && \
  curl https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb > /tmp/grafana.deb && \
  dpkg -i /tmp/grafana.deb && \
  rm /tmp/grafana.deb && \
  curl -L https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 > /usr/sbin/gosu && \
  chmod +x /usr/sbin/gosu && \
  for plugin in $(curl -s https://grafana.net/api/plugins?orderBy=name | jq '.items[] | select(.internal=='false') | .slug' | tr -d '"'); do grafana-cli plugins install $plugin; done && \
  ### zabbix ### && \
  git clone -b v3.0.0-beta1 https://github.com/alexanderzobnin/grafana-zabbix /var/lib/grafana/plugins/zabbix-app && \
  ### branding && \
  sed -i 's#<title>Grafana</title>#<title>Grafana XXL</title>#g' /usr/share/grafana/public/views/index.html && \
  sed -i 's#<title>Grafana</title>#<title>Grafana XXL</title>#g' /usr/share/grafana/public/views/500.html && \
  sed -i 's#icon-gf-grafana_wordmark"></i>#icon-gf-grafana_wordmark"> XXL</i>#g' /usr/share/grafana/public/app/app_bundle.js && \
  sed -i 's#icon-gf-grafana_wordmark"></i>#icon-gf-grafana_wordmark"> XXL</i>#g' /usr/share/grafana/public/app/boot.js && \
  sed -i 's#icon-gf-grafana_wordmark"></i>#icon-gf-grafana_wordmark"> XXL</i>#g' /usr/share/grafana/public/app/boot.*.js && \
  sed -i 's#icon-gf-grafana_wordmark"></i>#icon-gf-grafana_wordmark"> XXL</i>#g' /usr/share/grafana/public/app/core/components/navbar/navbar.html && \
  sed -i 's#icon-gf-grafana_wordmark"></i>#icon-gf-grafana_wordmark"> XXL</i>#g' /usr/share/grafana/public/app/core/partials.js && \
  sed -i 's#icon-gf-grafana_wordmark"></i>#icon-gf-grafana_wordmark"> XXL</i>#g' /usr/share/grafana/public/app/partials/signup_step2.html && \
  sed -i 's#icon-gf-grafana_wordmark"></i>#icon-gf-grafana_wordmark"> XXL</i>#g' /usr/share/grafana/public/app/partials/signup_invited.html && \
  sed -i 's#icon-gf-grafana_wordmark"></i>#icon-gf-grafana_wordmark"> XXL</i>#g' /usr/share/grafana/public/app/partials/signup_invited.html && \
  sed -i 's#icon-gf-grafana_wordmark"></i>#icon-gf-grafana_wordmark"> XXL</i>#g' /usr/share/grafana/public/app/partials/login.html && \
  sed -i 's#icon-gf-grafana_wordmark"></i>#icon-gf-grafana_wordmark"> XXL</i>#g' /usr/share/grafana/public/app/partials/reset_password.html && \
  chmod +x /run.sh && \
  apt-get remove -y --force-yes curl git jq && \
  apt-get autoremove -y --force-yes && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*  

VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

ENTRYPOINT ["/run.sh"]
