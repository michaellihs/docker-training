#!/usr/bin/env bash

UCP_IP="206.189.54.85"
UCP_FQDN="bos247"
docker run --rm -it --name ucp \
  -v /var/run/docker.sock:/var/run/docker.sock \
  docker/ucp:3.0.0 install \
  --admin-username admin \
  --admin-password adminadmin \
  --san ${UCP_IP} \
  --san ${UCP_FQDN} \
  --host-address ${UCP_IP}
