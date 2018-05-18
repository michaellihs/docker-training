#!/usr/bin/env bash

docker service create --name app \
  --health-interval 2s \
  --health-timeout 2s \
  --health-retries 3 \
  --health-start-period 10s \
  -p 5000:5000 training/healthcheck:ee2.0