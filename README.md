# Grafana XXL [![Deploy to Docker Cloud](https://files.cloud.docker.com/images/deploy-to-dockercloud.svg)](https://cloud.docker.com/stack/deploy/?repo=https://github.com/monitoringartist/grafana-xxl)

**Grafana 3.0 is still DEV preview!!!**

Official Grafana 3.0 with preinstalled plugins: Zabbix - datasource, Zabbix triggers - panel, worldPing - app, ...

Please donate to author, so he can continue to publish another awesome projects
for free:

[![Paypal donate button](http://jangaraj.com/img/github-donate-button02.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=8LB6J222WRUZ4)

# Running your Grafana XXL Docker image

Start your image binding the external port 3000:

    docker run -d --name=grafana-xxl -p 3000:3000 monitoringartist/grafana-xxl:3.0

Try it out, default admin user is admin/admin.

## Grafana XXL with persistent storage (recommended)

    # create /var/lib/grafana as persistent volume storage
    docker run -d -v /var/lib/grafana --name grafana-xxl-storage busybox:latest

    # start grafana-xxl
    docker run \
      -d \
      -p 3000:3000 \
      --name grafana-xxl \
      --volumes-from grafana-xxl-storage \
      monitoringartist/grafana-xxl:3.0

## Running specific version of Grafana XXL

    # specify right tag, e.g. 3.0 - see Docker Hub for available tags
    docker run \
      -d \
      -p 3000:3000 \
      --name grafana-xxl \
      monitoringartist/grafana-xxl:3.0
      
## Configuring your Grafana container

All options defined in conf/grafana.ini can be overriden using environment
variables, for example:

    docker run \
      -d \
      -p 3000:3000 \
      --name=grafana-xxl \
      -e "GF_SERVER_ROOT_URL=http://grafana.server.name" \
      -e "GF_SECURITY_ADMIN_PASSWORD=secret" \
      monitoringartist/grafana-xxl:3.0
      
# Included plugins

See plugin projects also for documentation:

- [Zabbix - datasource](https://github.com/alexanderzobnin/grafana-zabbix)
- [Zabbix trigger - panel](https://github.com/alexanderzobnin/grafana-zabbix)
- [worldPing - app](https://github.com/raintank/worldping-app)
- [piechart - panel](https://github.com/grafana/piechart-panel)
...

Please report any plugin issues directly to the author. Keep in mind Grafana 3.0 is dev preview!

Integrations
============

* [Puppet for dockerized grafana-xxl](https://github.com/monitoringartist/grafana-xxl/blob/master/puppet.md)
* [Ansible for dockerized grafana-xxl](https://github.com/monitoringartist/grafana-xxl/blob/master/ansible.md)
* [docker-compose for dockerized grafana-xxl](https://github.com/monitoringartist/grafana-xxl/blob/master/docker-compose.yml)

# Author

[Devops Monitoring zExpert](http://www.jangaraj.com 'DevOps / Docker / Kubernetes / Zabbix / Zenoss / Monitoring'), who loves monitoring
systems, which start with letter Z. Those are Zabbix and Zenoss.

Professional monitoring services:

[![Monitoring Artist](http://monitoringartist.com/img/github-monitoring-artist-logo.jpg)](http://www.monitoringartist.com 'DevOps / Docker / Kubernetes / Zabbix / Zenoss / Monitoring')
