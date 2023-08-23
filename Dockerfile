FROM ubuntu/bind9

RUN apt update \
  && apt install -y \
  bind9-doc \
  sudo \
  geoip-bin \
  nano \
  vim \
  curl \
  docker \  
  net-tools \
  iputils-ping \
  iputils-tracepath \
  traceroute \
  dnsutils

COPY config/named.conf /etc/bind/
COPY config/named.conf.local /etc/bind/
COPY config/named.conf.options /etc/bind/
COPY config/db.safbiz.co.ke /etc/bind/
COPY config/db.41.203.208.rev /etc/bind/

RUN chown -R bind:bind /etc/bind/

USER bind
# Expose Ports
EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 953/tcp
