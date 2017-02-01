# Grafana, Graphite, Statds Stack

This is a simple-to-deploy docker-compose stack that runs `graphite` with a `statsd` interface, and the
most recent version of `grafana`, and includes some support files for running a `collectd` metrics
gatherer on machines in your network.

This is essentially an open source "datadog".

There are many related docker images available on Dockerhub, but none of them work strait out of the box,
and all the ones that include Grafana use a much older version of it.

## Configuration

### Graphite Storage Retention Policies

You can edit the "graphite/storage-schemas.conf" file to change the default storage retention
policy.  [This](http://graphite.readthedocs.io/en/latest/config-carbon.html) is a good article
explaining what this means and how to change it.

### Grafana Web Admin Password

Edit "docker-compose.yml" and change "GF_SECURITY_ADMIN_PASSWORD".  Also edit "./grafana/run-grafana.sh" to match.

### Grafana Email Alerts

To send alerts via email, you must set up SMTP settings.  Add the following variables with the
correct values into the "environment" section of the "grafana" service:

    GF_SMTP_ENABLED: "true"
    GF_SMTP_HOST: "your-smtp-host:port"
    GF_SMTP_USER: "username"
    GF_SMTP_PASSWORD: "password"
    GF_SMTP_SKIP_VERIFY: "true"
    GF_SMTP_FROM_ADDRESS: "alerts@example.com"

See [smtp doc](http://docs.grafana.org/installation/configuration/#smtp) for more settings.

## Deploy

```bash
docker-compose build
docker-compose up -d
```

The Grafana UX is running on port 80 of the docker machine you deployed to.  The default admin
user name is "admin".  The default password is "secret".

There is an example dashboard you can import here called "collectd-dashboard.json".  If you import that
you should see some metrics for the stack you just launched.

## Ports

| Port | Service |
|------|---------|
|   80 | grafana UX |
| 2003 | carbon receiver - plain text |
| 2004 | carbon receiver - pickle |
| 2023 | carbon aggregator - plain text |
| 2024 | carbon aggregator - pickle |
| 8125/udp | statsd |
| 8126 | statsd admin |

You can remove the ports you do not use.  The `collectd` service uses 2003.  Your application, if it writes
its own metrics, will probably use 8125.

### Installing Grafana Plugins

```bash
docker exec -it grafana grafana-cli plugins install grafana-piechart-panel
docker-compose restart grafana
```

## CollectD

The `collectd` daemon can be used to collect stats on a running Linux host and send them to graphite so
you can see them in grafana.  In fact, included in this stack is a container that does just this, called
"metrics", for the stack.

There are some support files here to get you started if you want to run more collectd services.  You would
want only one of these per physical machine in your environment.

Basically, use the files under "./collectd".  Edit the Dockerfile and change **GRAPHITE_HOST** to point to
the host name or IP or container name (if you are using linking) of the "graphite" server (the one hosting port 2003).

Then:

```bash
docker build -t my-collectd -f collectd/Dockerfile .
docker run -d --name my-collectd --hostname my-hostname --privileged my-collectd
```

Or look at the "metrics" section of docker-compose.yml.

# References

For Grafana beginners, see [this](http://docs.grafana.org/tutorials/screencasts/).

Containers used:

* [Grafana](https://github.com/grafana/grafana-docker)
* [Graphite](https://github.com/hopsoft/docker-graphite-statsd)
* [Collectd](https://github.com/pataquets/docker-collectd)

A docker container that monitors other docker containers using collectd might be useful.
See [this](https://github.com/bobrik/collectd-docker).

