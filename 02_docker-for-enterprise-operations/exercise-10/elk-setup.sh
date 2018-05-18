#!/usr/bin/env bash

cd
git clone -b ee2.0 https://github.com/docker-training/elk-dee.git
cd elk-dee
export LOGSTASH_HOST=159.89.104.42
docker stack deploy -c journalbeat-docker-compose.yml journalbeat
