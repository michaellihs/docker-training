#!/usr/bin/env bash

docker service create --name demo \
    --network demo \
    --label com.docker.lb.hosts=demo.local \
    --label com.docker.lb.port=8000 \
    training/whoami:latest

