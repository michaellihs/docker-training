Docker Enterprise for Operations
================================

[TOC levels=1-3]: # " "

- [Docker Enterprise for Operations](#docker-enterprise-for-operations)
- [Login on CLI](#login-on-cli)
- [Install `kubectl` on Mac](#install-kubectl-on-mac)
- [Run commands against API](#run-commands-against-api)


Login on CLI
------------

Check credentials in `login.sh`, then run

    source ./login.sh


Install `kubectl` on Mac
------------------------

Run

    brew install kubectl


Run commands against API
------------------------

* get all containers

   ```
   ucp-api "https://${UCP_FQDN}/containers/json" | jq
   ```


Healthchecks
============

We have a `HEALTHCHECK` command in the `Dockerfile`

    HEALTHCHECK CMD curl --fail http://localhost:5000/health || exit 1

There is also an instruction for Compose File

    healthcheck:
      intervals: 10s
      timeout: 2s
      retries: 3
      start-time: 30s

see

* https://blog.newrelic.com/2016/08/24/docker-health-check-instruction/
* https://github.com/gitlabhq/omnibus-gitlab/blob/master/docker/Dockerfile#L43


Minio with Docker
=================

Docker compose file for Minio
-----------------------------

See http://bit.ly/2DmDvxq for a Docker Compose file for Minio.