FROM pataquets/collectd

# Build our custom collectd.conf file:
# Disable FQDN lookup to avoid collectd complaining.

# CHANGE THIS TO POINT TO YOUR GRAPHITE HOST.
# "graphite" only works if you are linking to the graphite
# container, which you probably can't do...
#
# ENV GRAPHITE_HOST ec2-52-10-118-52.us-west-2.compute.amazonaws.com

ADD collectd/write-graphite.conf /etc/collectd/conf-available/write-graphite.conf
# RUN sed -i "s/__graphite__/$GRAPHITE_HOST/g" /etc/collectd/conf-available/write-graphite.conf
ADD collectd/read-interface.conf /etc/collectd/conf-available/read-interface.conf
COPY collectd/run.sh /run.sh
ENTRYPOINT [ "/run.sh" ]
