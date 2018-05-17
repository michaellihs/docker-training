Docker for Enterprise Operations 2018-05-17
===========================================

Read it like "Docker for Enterprise - Operations", so we learn about operations with Docker for Enterprise.


[TOC levels=1-3]: # " "

- [Docker for Enterprise Operations 2018-05-17](#docker-for-enterprise-operations-2018-05-17)
    - [Docker EE Features](#docker-ee-features)
    - [Architecture / Configuration](#architecture--configuration)
- [Resources](#resources)


Docker EE Features
------------------

* Build
  * Security Scanning - check whether known vulnerabilities are in your images
  * Repository automation
* Ship
  * Content Trust - sign your images
* Run
 * RBAC
* Monitoring


Architecture / Configuration
----------------------------

* Overall architecture
  * Docker (Swarm) Cluster consists of UCP Manager and UCP Workers
  * DTR consists of load balanccer and replicated DTR workers
    * require shared file system (e.g. NFS or S3)
* Docker EE API can talk
  * "Classic" Swarm
  * SwarmKit (current Swarm)
  * Kubernetes
* UCP itself is a bunch of containers running in Docker itself
* Cluster Configuration
  * Odd number of managers
  * Don't run workload on managers
  * Do not terminate HTTPS in manager LB
  * `https://206.189.54.85/_ping` shows manager health


Resources
=========

* [Linux Cheat Sheet](https://www.cheatography.com/davechild/cheat-sheets/linux-command-line/)
