FROM grafana/grafana
RUN apt-get update && apt-get install -y curl && apt-get clean
# This script will install graphite as a data source
COPY ./grafana/run-grafana.sh /run-grafana.sh
ENTRYPOINT ["/run-grafana.sh"]
