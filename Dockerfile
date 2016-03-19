FROM debian:jessie
MAINTAINER Jan Garaj info@monitoringartist.com

# inbuilt datasources:
# cloudwatch elasticsearch grafana graphite influxdb mixed opentsdb prometheus
# sql kairosdb

ENV GRAFANA_VERSION 3.0.0-pre1   

COPY ./run.sh /run.sh

RUN \
  apt-get update && \
  apt-get -y --force-yes --no-install-recommends install libfontconfig curl ca-certificates git && \
  curl https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb > /tmp/grafana.deb && \
  dpkg -i /tmp/grafana.deb && \
  rm /tmp/grafana.deb && \
  curl -L https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 > /usr/sbin/gosu && \
  chmod +x /usr/sbin/gosu && \
  # grafana-cli install example-app && \
  # grafana-cli install simple-json-datasource && \
  # grafana-cli install worldping-app && \
  # grafana-cli install piechart-panel && \
  # grafana-cli install pie-chart && \
  # grafana-cli install influxdb-08-datasource && \
  # grafana-cli install kairosdb-datasource && \
  # grafana-cli install <plugin-id> && \
  # grafana-cli install <plugin-id> && \
  # grafana-cli install <plugin-id> && \
  mkdir -p /usr/share/grafana-plugins && \    
  ### zabbix ### && \
  git clone -b develop https://github.com/jangaraj/grafana-zabbix /tmp/grafana-zabbix && \
  cp -r /tmp/grafana-zabbix/plugins/* /usr/share/grafana-plugins && \
  #mkdir -p /usr/share/grafana/public/app/plugins/datasource/zabbix && \
  #mkdir -p /usr/share/grafana/public/app/plugins/panel/zabbix && \
  #mv /tmp/grafana-zabbix/plugins/datasource-zabbix/* /usr/share/grafana/public/app/plugins/datasource/zabbix/ && \
  #mv /tmp/grafana-zabbix/plugins/panel-triggers/* /usr/share/grafana/public/app/plugins/panel/zabbix/ && \
  rm -rf /tmp/grafana-zabbix/ && \
  ### others plugins from GitHub ### && \
  git clone https://github.com/grafana/piechart-panel /usr/share/grafana-plugins/piechart-panel && \
  git clone https://github.com/grafana/influxdb-08-datasource /usr/share/grafana-plugins/influxdb-08-datasource && \
  git clone https://github.com/grafana/kairosdb-datasource /usr/share/grafana-plugins/kairosdb-datasource && \
  git clone https://github.com/raintank/worldping-app /usr/share/grafana-plugins/worldping-app && \
  git clone https://github.com/grafana/example-app /usr/share/grafana-plugins/example-app && \
  git clone https://github.com/grafana/simple-json-datasource /usr/share/grafana-plugins/simple-json-datasource && \
  git clone https://github.com/raintank/snap-app /usr/share/grafana-plugins/snap-app && \
  #git clone https://github.com/raintank/gitstats-app /usr/share/grafana-plugins/gitstats-app && \    
  ### dataloop - NOT 3.0 READY ### && \
  #git clone https://github.com/dataloop/grafana-plugin /usr/share/grafana/public/app/plugins/datasource/dataloop && \
  #rm -rf /usr/share/grafana/public/app/plugins/datasource/dataloop/.git && \
  ### atlas atsd bosun clouderamanager druid gnocchi - NOT 3.0 READY ### && \
  #git clone https://github.com/grafana/grafana-plugins /tmp/grafana-plugins && \
  #rm -rf /tmp/grafana-plugins/datasources/zabbix && \
  #mv /tmp/grafana-plugins/datasources/* /usr/share/grafana/public/app/plugins/datasource/ && \
  #rm -rf /tmp/grafana-plugins && \
  ### PRTG - NOT 3.0 READY ### && \
  #git clone https://github.com/neuralfraud/grafana-prtg /tmp/grafana-prtg && \
  #mv /tmp/grafana-prtg/PRTG/ /usr/share/grafana/public/app/plugins/datasource/ && \
  #rm -rf /tmp/grafana-prtg && \
  ### ambari - NOT 3.0 READY ### && \
  #git clone https://github.com/u39kun/ambari-grafana /tmp/ambari-grafana && \
  #mv /tmp/ambari-grafana/ambari/ /usr/share/grafana/public/app/plugins/datasource/ && \
  #rm -rf /tmp/ambari-grafana && \
  ### dalmatinerdb - NOT 3.0 READY ### && \
  # git clone https://github.com/dalmatinerdb/dalmatiner-grafana-plugin /tmp/dalmatiner-grafana-plugin && \
  # mv /tmp/dalmatiner-grafana-plugin/dalmatinerdb/ /usr/share/grafana/public/app/plugins/datasource/ && \
  # rm -rf /tmp/dalmatiner-grafana-plugin && \
  ### opennms - NOT 3.0 READY && \
  #echo "deb http://debian.opennms.org opennms-17 main\ndeb-src http://debian.opennms.org opennms-17 main" > /etc/apt/sources.list.d/opennms.list && \
  #curl -s https://debian.opennms.org/OPENNMS-GPG-KEY | apt-key add - && \   
  #sleep 10 && \
  #apt-get update && \
  #apt-get install -y grafana-opennms-plugin && \
  #rm -rf /etc/apt/sources.list.d/opennms.list && \
  ### kairosdb ### && \
  #git clone https://github.com/br0th3r/grafana2-kairosdb-datasource-plugin /tmp/grafana2-kairosdb-datasource-plugin && \
  #mv /tmp/grafana2-kairosdb-datasource-plugin/kairosdb/ /usr/share/grafana/public/app/plugins/datasource/ && \
  #rm -rf /tmp/grafana2-kairosdb-datasource-plugin && \
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
  apt-get remove -y --force-yes curl git && \
  apt-get autoremove -y --force-yes && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*  

VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

ENTRYPOINT ["/run.sh"]
