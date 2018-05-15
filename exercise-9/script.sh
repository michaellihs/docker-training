#!/usr/bin/env bash

docker image tag centos:7 my-centos:dev
docker image ls
docker login
docker image push my-centos:dev
docker image tag my-centos:dev michaellihs/my-centos:dev
docker push michaellihs/my-centos:dev

docker image build -t michaellihs/my-centos-vim:dev .
