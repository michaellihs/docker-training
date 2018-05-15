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
- [Docker Commands Cheat Sheet](#docker-commands-cheat-sheet)
    - [`docker container`](#docker-container)
    - [`docker image`](#docker-image)
- [Dockerfile](#dockerfile)
    - [`ENTRYPOINT` and `CMD`](#entrypoint-and-cmd)
    - [`ADD` and `COPY`](#add-and-copy)
    - [`ENV` and `ARG`](#env-and-arg)
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


Resources
=========

* [Go text/template package](https://golang.org/pkg/text/template/)
* [Container Tutorial](https://github.com/jpetazzo/container.training)
* [Code Golf](https://codegolf.stackexchange.com/questions)
* [Best Practices for Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

