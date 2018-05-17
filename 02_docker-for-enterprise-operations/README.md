Docker for Enterprise Operations 2018-05-17
===========================================

Read it like "Docker for Enterprise - Operations", so we learn about operations with Docker for Enterprise.


[TOC levels=1-3]: # " "

- [Docker for Enterprise Operations 2018-05-17](#docker-for-enterprise-operations-2018-05-17)
    - [Docker EE Features](#docker-ee-features)
    - [Architecture](#architecture)
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


Architecture
------------

* Overall architecture
  * Docker (Swarm) Cluster consists of UCP Manager and UCP Workers
  * DTR consists of load balanccer and replicated DTR workers
    * require shared file system (e.g. NFS or S3)
* Docker EE API can talk
  * "Classic" Swarm
  * SwarmKit (current Swarm)
  * Kubernetes


Resources
=========

* [Linux Cheat Sheet](https://www.cheatography.com/davechild/cheat-sheets/linux-command-line/)
