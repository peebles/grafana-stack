#!/bin/bash
sed -i "s/__graphite__/$GRAPHITE_HOST/g" /etc/collectd/conf-available/write-graphite.conf
cat \
    /etc/collectd/conf-available/global-FQDNLookup-disable.conf \
    /etc/collectd/conf-available/read-load.conf \
    /etc/collectd/conf-available/read-df-all.conf \
    /etc/collectd/conf-available/read-interface.conf \
    /etc/collectd/conf-available/read-memory.conf \
    /etc/collectd/conf-available/write-graphite.conf \
    | tee -a /etc/collectd/collectd.conf

# Print resulting collectd.conf file, just to be sure.
nl /etc/collectd/collectd.conf

exec collectd -f
