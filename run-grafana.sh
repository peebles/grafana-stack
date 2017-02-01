#!/bin/bash
echo 'Starting Grafana...'
/run.sh "$@" &
AddDataSource() {
  curl 'http://admin:admin@localhost:3000/api/datasources' \
    -X POST \
    -H 'Content-Type: application/json;charset=UTF-8' \
    --data-binary \
    '{"name":"graphite","type":"graphite","url":"http://graphite:80","access":"proxy","isDefault":true}'
}
until AddDataSource; do
  echo 'Configuring Grafana...'
  sleep 1
done
echo 'Done!'
wait
