#!/usr/bin/env bash

DTR_FQDN=bos247
UCP_IP=206.189.54.85

docker run -it --rm docker/dtr:2.5.0 install \
  --ucp-node bos247 \
  --ucp-username admin \
  --ucp-password adminadmin \
  --ucp-url https://${UCP_IP} \
  --ucp-insecure-tls \
  --replica-https-port 4443 \
  --replica-http-port 81 \
  --dtr-external-url https://${DTR_FQDN}:4443
