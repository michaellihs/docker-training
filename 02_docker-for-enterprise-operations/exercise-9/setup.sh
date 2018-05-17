#!/bin/bash 

set -x

docker network create \
  --driver overlay \
  --attachable \
  frontend

docker network create \
  --driver overlay \
  backend

docker service create --name web \
  --network frontend \
  --replicas 3 \
  --publish 3000:8000 \
  training/whoami:latest

docker service create --name worker \
  --network backend \
  --replicas 3 \
  --publish 3100:8000 \
  training/whoami:latest

docker container run --rm -it \
  --network frontend \
  alpine:latest /bin/sh

