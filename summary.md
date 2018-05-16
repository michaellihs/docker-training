Docker Training 15.5.2018
=========================

[TOC levels=1-3]: # " "

- [Docker Training 15.5.2018](#docker-training-1552018)
    - [Training Concepts](#training-concepts)
    - [Kubernetes vs. Swarm](#kubernetes-vs-swarm)
    - [Problems with Deploying / moving software](#problems-with-deploying--moving-software)
    - [VMs vs Container](#vms-vs-container)
    - [PIDs, Namespaces](#pids-namespaces)
        - [On the host](#on-the-host)
        - [Inside the container](#inside-the-container)
    - [Capabilities & Syscall Permissions](#capabilities--syscall-permissions)
    - [Container Logs](#container-logs)
    - [Security](#security)
- [Images, FS](#images-fs)
    - [Best Practices for building images](#best-practices-for-building-images)
    - [Multi-Stage builds](#multi-stage-builds)
- [Docker Registry](#docker-registry)
- [Dockerfile](#dockerfile)
    - [`ENTRYPOINT` and `CMD`](#entrypoint-and-cmd)
    - [`ADD` and `COPY`](#add-and-copy)
    - [`ENV` and `ARG`](#env-and-arg)
- [Volumes](#volumes)
- [Networking](#networking)
    - [Networking Security](#networking-security)
- [Docker Compose](#docker-compose)
- [Docker Swarm](#docker-swarm)
- [Kubernetes](#kubernetes)
    - [Setup Kubernetes](#setup-kubernetes)
- [Docker Commands Cheat Sheet](#docker-commands-cheat-sheet)
    - [`docker container`](#docker-container)
    - [`docker image`](#docker-image)
    - [`docker volume`](#docker-volume)
    - [`docker network`](#docker-network)
    - [`docker-compose`](#docker-compose)
    - [`docker swarm`](#docker-swarm)
    - [`docker service`](#docker-service)
    - [`docker node`](#docker-node)
    - [`kubeadm`](#kubeadm)
    - [`kubectl`](#kubectl)
- [Tools](#tools)
- [Resources](#resources)




Training Concepts
-----------------

* learning by doing
* slides & exercise book as PDF via email


Kubernetes vs. Swarm
--------------------

* Kubernetes only allows deployment of PODs, no containers
* different commands
* Kubernetes is "independent" of Docker but mostly uses Docker


Problems with Deploying / moving software
-----------------------------------------

* Software has dependencies
  * requires many people / departments to setup dependencies on systems
* Solution: encapsulation of software + dependencies
  * eliminates friction
  * standardization facilitates scale


VMs vs Container
----------------

* ratio between system requirements of the VM and the application in the VM
* requires guest OS
* containers are kernel features
  * isolation of certain resources


PIDs, Namespaces
----------------

### On the host

1 --> /sbin/initd   (root of PID tree)
  --> dockerd
  --> runc
  --> container

### Inside the container

1 --> process started / ran inside the container (is also a process on the host, but has a different PID there)

Has its own filesystem, mountpoints and network stack


Capabilities & Syscall Permissions
----------------------------------

* e.g. `CAP_NET_BIND_SERVICE`
  * bind ports < 1024
* capabilities can be allowed on per-container basis


Container Logs
--------------

* container logs to stdout and stderr
* `docker container logs <container name>`
* rule for app development: do not log to file, log to stream
  * enables centralized log collection
  * attacker cannot manipulate logs, if they are streamed


Security
--------

* namespacing restricts attackers to the resources available to the container
* best practices
  * no shell in container
  * only a single application should run in container
  * no package manager in container
  * ... make sure that "standard exploit scripts" are not working in container --> [metasploit](https://www.metasploit.com/)
* set pid limit in `docker container run --pids-limit <int>` --> i.e. limit number of processes to 1


Images, FS
==========

* Copy-on-write
  * files in lower FS layers are read-only
  * whenever I want to (over)write a file, the file is first copied into my layer, in which I can write
* How to create an image - 3 possibilities:
  * use `commit`
  * use `Dockerfile`
  * import from a tarball


Best Practices for building images
----------------------------------

* move parts that change frequently towards the end of the `Dockerfile`
  * make more effective use of layer caching
* when building a Docker image, the whole build context (current dir) is sent to Docker engine
  * make use of `.dockerignore` to exclude files (e.g. `.git`)
* inspect intermediate container for debugging, if a command in `Dockerfile` failed
  * run failed command interactively on the last successfully build layer
* get rid off all build tools in production images
  * e.g. JDK is not to be used in production containers
* with dependency managers (e.g. maven...)
  * add dependency file to Docker images BEFORE running dependency management
* careful with `:latest` tag, this does not mean that an image is the most recent one, it's just the image that is taken as default
  * if no tag is given, Docker will use `:latest`
  * should rather be named `:default`


Multi-Stage builds
------------------

*  Problem: building software in container requires e.g. and SDK in the image
  * once compiled, the SDK is no longer required
  * question: how can I get rid of it in production container
  * use

     ```
     FROM ... as <name>
     ...
     FROM ...
     COPY --from=<name> <path>
     ```


Docker Registry
===============

* where to put the Root CA (of the proxy)?
  * keystore of OS should be sufficient


Dockerfile
==========

* every line in the `Dockerfile` is run in an isolated shell
  * this

      ```
      RUN cd /src
      RUN bash setup.sh
      ```

   * is different to

      ```
      RUN cd /src && bash setup.sh
      ```
* build process with `Dockerfile` should be reproducible
  * be careful with `yum update` ...
* build cache only checks changes in `Dockerfile`
* be on the safe side and use `--no-cache`

`ENTRYPOINT` and `CMD`
----------------------

* `ENTRYPOINT` and `CMD` are two lists that get concatenated like `ENTRYPOINT` + `CMD` when the container is run
* `CMD` provides a command that is run, when the container is started
* if an `ENTRYPOINT` is provided, the command(s) given in `COMMAND` are appended to the command in `ENTRYPOINT`
  * given an `ENTRYPOINT` the parameters passed on the `docker run...` command replace the `COMMAND` parameters
* you can have an `ENTRYPOINT` in a base image and parametrize this with `CMD` in a child image
* `CMD` and `ENTRYPOINT` can be written in either
  * Shell form (provides full shell features, requires a shell in the container):

     ```
     CMD sudo -u ${USER} java ...
     ```

  * Exec form (requires no shell in container):

     ```
     CMD ["sudo", "-u", "user", "java"]
     ```

`ADD` and `COPY`
----------------

* `COPY` copies files from build context into image
* `ADD` can also download URLs from internet and extract TARs


`ENV` and `ARG`
---------------

* `ENV` is for runtime (environment variable)
* `ARG` is for build time (required during build)


Volumes
=======

* persist data beyond the container lifecycle
* provide R/W path separate from the layered filesystem
  * bypass the copy-on-write filesystem
* can be defined in `Dockerfile`
  * only volume inside the container can be specified
  * cannot map volumes on host system
* when starting a container with a mounted volume and creating an image from it, the mountpoint is captured in the image, but the files inside the mounted volume are not captured


Networking
==========

* containers are never visible in the public network of the host
* `docker0` is a linux bridge that
  * acts as a switch so that multiple containers can communicate with each other
  * acts as a router so that the container can access internet
* custom bridges can be created
  * custom bridges can resolve DNS names (which equals the container name) to their IP addresses
* networking tools for bridges:

   ```
   yum install bridge-utils
   brctl show docker0
   ```

Networking Security
-------------------

* do not use the `host` network in production
* do not connect containers to the same network unnecessarily


Docker Compose
==============

* `docker-compose` is mainly a development tool nowadays
* a **service** defines a desired state of a group of identically configured containers
  * **service discovery / load balancing** services are assigned a virtual IP which spreads traffic out across underlying containers


Docker Swarm
============

* Swim Protocol https://asafdav2.github.io/2017/swim-protocol/
* Raft Consensus https://raft.github.io/
* Swarm network consists of Manager and Workers
  * https://docs.docker.com/engine/swarm/how-swarm-mode-works/nodes/
* Multiple planes - see https://gist.github.com/BretFisher/7233b7ecf14bc49eb47715bbeb2a2769 for ports
  * mgmt plane
  * control plane
  * data plane
* in comparison to compose, a `service` in swarm can describe a collection of containers
* `task` is a unit of work assigned to a node
* Docker suggests to have at most 7 managers in a cluster
  * with only 2 managers, Swarm will no longer process changes anymore


Kubernetes
==========

* Nowadays fully managed by the CNCF
* Kubernetes Core Objects see https://kubernetes.io/docs/concepts/#kubernetes-objects
  * **Pod** group of co-located containers, smallest unit that can be deployed in Kubernetes
  * **ReplicaSet** collection of pods (like service in Docker)
  * **Service** reliable networking endpoint for a set of Pods
  * **Deployment** declarative governance of Replica set (update strategies...)
* all containers in a pod share same IP
* Pod networking
  * all applications in a pod have a common shared veth interface
  * see https://medium.com/@ApsOps/an-illustrated-guide-to-kubernetes-networking-part-1-d1ede3322727
* Kubernetes itself does not have multi-host networking
  * outsourced to plugin: Flannel, Weave, ...
  * see https://kubernetes.io/docs/concepts/cluster-administration/networking/
* Kubernetes networking planes
  * Management
    * master to master: etcd Raft
    * master to node: apiserver <-> kubelet
* Data & Control
  * BYO networking
  * Cluster DNS


Setup Kubernetes
----------------

* `kubeadm init` initialize Kubernetes cluster / manager
* create config folder in home dir

   ```
   mkdir -p $HOME/.kube
   sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config
   sudo chown $(id -u):$(id -g) ~/.kube/config
   ```

* `kubectl get nodes` list nodes
* `kubectl apply -n kube-system -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"` install overlay network plugin
* `kubectl get pods -n kube-system` list pods
* `kubectl run nginx --image nginx` run an image (as deployment?)
* `kubectl get deployments` get deployments
* `kubectl get pods`
* `kubectl describe pods nginx-65899c769f-mk6sw` get pod details
* `kubectl logs deployments/nginx` check logs
* `kubectl expose deployments/nginx --port 8080 --target-port 80` make app accessible on forwarded port
* `kubectl get services` get services
* open service in browser

   ```
   IP=$(kubectl get service nginx -o go-template --template '{{ .spec.clusterIP}}')
   curl http://${IP}:8080
   ```

* generate some logs

   ```
   curl http://${IP}:8080
   curl http://${IP}:8080
   kubectl logs deployments/nginx
   ```

* `kubectl scale deployments/nginx --replicas 3` scale application
* `kubectl get pods -o wide -w` verify we have 3 pods


Docker Commands Cheat Sheet
===========================

`docker container`
------------------

* `start <ID>` starts container with given `ID`
* `ls -l` list last container to have been created
* `ls -a --filter "exited=0"` list all containers that exited with exit code `0`
* `attach <CONTAINER ID>` attach a terminal to a containers PID 1
  * exiting with `CTRL + C` will **kill the container**
  * exiting with `CTRL + P` and `CTRL + Q` will keep the container running
  * for checking logs, user `docker container logs` instead
* `logs --tail <LINES> <container ID>` shows last `LINES` lines of logs of container with `container ID`
* `inspect --format "{{json .Config}}" <container ID> | jq` pipe `.Config` section to `jq` in JSON format
* chaining of commands `docker container rm -f $(docker container ls -l -q)` deletes the last created container
* `docker container diff $(docker container ls -l -q)` diff changes made to a container (in comparison to a underlying image)
* `docker container commit <container ID> <image name>:<version>` - create a new image from a given container
* `port` shows port mappings of containers
* `run -p <host-port>:<container-port>` maps `container-port` inside the container to `host-port` on the host machine
* `run -P` map all ports mentioned in the `Dockerfile`'s `EXPOSE` directive
* `prune` remove all stopped containers


`docker image`
--------------

* `ls` list (locally) available Docker images
* `build -t <image name> <path to Dockerfile>` build image from given Dockerfile and tag it with `image name`
* `cat Dockerfile | docker image build -t myimage -f - .` build image from Dockerfile piped to STDIN
* `history <image id>`inspect build cache history of an image
* `build --squash` merge all image layers into a single layer
* `tag <old tag> <new tag>` tag an already existing image
  * tagging for upload to registry `[[registry FQDN/]username/]image_name:tag`


`docker volume`
---------------

* `create --driver <volume driver> <volume name>` creates a volume with given name and driver
* mount host directories with `docker run -v [host path]:[container path]:[rw|ro]`
  * e.g. for mounting source code into the container in dev environments
* `ls` show available volumes
* `inspect <volume id>` shows details about the volume
* `rm <volume id>` remove volume


`docker network`
----------------

* `ls` show networks

   ```
   NETWORK ID          NAME                DRIVER              SCOPE
   5aefee28b6d7        bridge              bridge              local
   cf9e4d2da99e        host                host                local
   fcb9953c4d29        none                null                local
   ```

* `inspect <network name>` details about given network
* `create --driver bridge my_bridge` creates a new custom bridge


`docker-compose`
----------------

* `up` start the application defined in your `docker-compose.yml`
  * pressing `CTRL + C` kills the app
* `up -d` sends application to the background
* `ps` shows running containers

   ```
           Name                      Command               State          Ports         
   ------------------------------------------------------------------------------------
   dockercoins_hasher_1   ruby hasher.rb                   Up      0.0.0.0:8002->80/tcp 
   dockercoins_redis_1    docker-entrypoint.sh redis ...   Up      6379/tcp             
   dockercoins_rng_1      python rng.py                    Up      0.0.0.0:8001->80/tcp 
   dockercoins_webui_1    node webui.js                    Up      0.0.0.0:8000->80/tcp 
   dockercoins_worker_1   python worker.py                 Up   
   ```
   `NAME` consists of `folder-name_service-name_instance`

* `logs` show logs of compose managed app
* `logs --tail 10 --follow` show the last 10 lines of the logs and follow afterwards
  * `CTRL+S` will pause the stream, `CTRL+Q` will resume the stream
* `scale <service name>=<number>` scales instances of `service name` to given number
* `down` shut down the app


`docker swarm`
--------------

* `init` enable swarm mode on whethever node is to be your first manager node
  * `docker system info` check that swarm mode is active

     ```
     Swarm: active
      NodeID: mkxf2lzk2guvwfw4h5e11ewuw
      Is Manager: true
      ClusterID: b5ewyezpvimlf6q8xttwv1x89
      Managers: 1
      Nodes: 1
      Orchestration:
       Task History Retention Limit: 5
      Raft:
       Snapshot Interval: 10000
       Number of Old Snapshots to Retain: 0
       Heartbeat Tick: 1
       Election Tick: 10
      Dispatcher:
       Heartbeat Period: 5 seconds
      CA Configuration:
       Expiry Duration: 3 months
       Force Rotate: 0
      Autolock Managers: false
      Root Rotation In Progress: false
      Node Address: 159.65.118.11
      Manager Addresses:
       159.65.118.11:2377
     ```

* `docker node ls` see all nodes in your swarm
* `docker swarm join-token worker` get (a new) join token on the manager node
* `docker swarm join --token <token> <ip>:2377` join a new node to the manager given by `ip` using `token`
* `docker node promote <node-1> <node-2>` promote workers on a manager where `node-1` and `node-2` are the hostnames of the workers to be promoted. Check with `docker node ls` afterwards

   ```
   ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
   mkxf2lzk2guvwfw4h5e11ewuw *   bos5                Ready               Active              Leader              18.03.1-ce
   m19mw7b8rn7xq57b748f7g42u     bos8                Ready               Active              Reachable           18.03.1-ce
   mm9h45t3zshdl98ijzbtyyv0z     bos46               Ready               Active              Reachable           18.03.1-ce
   u5k4e0t7ng395zklv2xydh4ad     bos52               Ready               Active                                  18.03.1-ce
   ```


`docker service`
----------------

* `ps <service name>` inspect a service
* `create <service name>` create a service with given name
  * example `docker service create --entrypoint "ping 8.8.8.8" alpine` creates (sample) service with given entrypoint based on given image
* `update <service name>` updates a given service, e.g. to set flags
  * e.g. `docker service update <service name> --replicas 6`


`docker node`
-------------

* `update --label-add datacenter=east bos5` set a label on a node


`kubeadm`
---------

* `init` initialize a Kubernetes cluster
* `join --token <TOKEN> <IP>:<PORT> --discovery-token-ca-cert-hash sha256` join a Kubernetes cluster with given token


`kubectl`
---------

* `get nodes` list all nodes in Kubernetes cluster
* `apply -n kube-system -f ...` install weave overlay network


`docker secret`
---------------

* `create <secret name> <path to file with password>` create a secret
* `echo 'abc1234' | docker secret create <secret name> -`
* `ls` list secrets
* `inspect <secret name>` get secret metadata
* `rm <secret name>` delete a secret


`docker system`
---------------

* `df` how much memory does Docker use
* `prune` reclaim all reclaimable space
* `events` start observing events in Docker


Tools
=====

* [hstr `hh`](https://github.com/dvorka/hstr)
* [httping](https://www.vanheusden.com/httping/)
* [brctl](https://www.thegeekstuff.com/2017/06/brctl-bridge/)


Resources
=========

* [Go text/template package](https://golang.org/pkg/text/template/)
* [Container Tutorial](https://github.com/jpetazzo/container.training)
* [Code Golf](https://codegolf.stackexchange.com/questions)
* [Best Practices for Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
* [Docker Labs: Networks](https://github.com/docker/labs/blob/master/networking/README.md)
* [Docker Training repositories](https://github.com/docker-training)
* [Docker Compose Reference](https://docs.docker.com/compose/compose-file/)
* [BORG & Kubernetes](https://kubernetes.io/blog/2015/04/borg-predecessor-to-kubernetes/)
* [Managing config with Docker](https://docs.docker.com/engine/swarm/configs/)

