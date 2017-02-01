## Beginners

    http://docs.grafana.org/tutorials/screencasts/

## Docker images used

    graphite + statsd
    https://hub.docker.com/r/hopsoft/graphite-statsd/
    
    grafana
    https://hub.docker.com/r/grafana/grafana/

## Possible way to auto-initialize graphite datasource

    `https://github.com/grafana/grafana/issues/1789`

**NOTE** THIS IS SOLVED.  SEE Dockerfile.grafana and docker-compose.yml.

## Configure collectd

    `https://www.digitalocean.com/community/tutorials/how-to-configure-collectd-to-gather-system-metrics-for-graphite-on-ubuntu-14-04`

## Deploy

```bash
docker-compose build
docker-compose up -d
```

## Installing Plugins

```bash
docker exec -it grafana grafana-cli plugins install grafana-piechart-panel
docker-compose restart grafana
```

## Import Dashboard

Edit collectd-dashboard.json, change "metrics" to the name of your host, and import this dashboard file.

## Grafana Authentication

If you change docker-compose with a different password, then you must change `run-grafana.sh` to match.
