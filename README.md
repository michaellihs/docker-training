Docker Training - 2018-05-15
============================

Transcript of Docker Fundamentals and Docker Enterprise Operations training 2018-05-15 - 2018-05-19.

* First Part: [Docker Fundamentals](01_docker-fundamentals/README.md)
* Second Part: [Docker for Enterprise Operations](02_docker-for-enterprise-operations/README.md)


**Table of Contents**

[TOC levels=1-3]: # " "

- [Docker Training - 2018-05-15](#docker-training---2018-05-15)
    - [SSH Configuration for Training Hosts](#ssh-configuration-for-training-hosts)
    - [`/etc/host` configuration](#etchost-configuration)
- [Tools](#tools)
    - [hstr](#hstr)


SSH Configuration for Training Hosts
------------------------------------

Use the following entries in your `~/.ssh/config`

    Host bos*
      User root
    
    Host bos247
      Hostname 206.189.54.85
    
    Host bos248
      Hostname 206.189.54.88
    
    ...

Copy your public ssh key to the machines using

    for i in bos247 bos248 bos251 bos252 bos253; do ssh-copy-id ${i}; done

Afterwards, you can login to the machines using

    ssh bosXXX


`/etc/host` configuration
-------------------------

For some applications it might be helpful to set hostnames and IP addresses of the training servers in your `/etc/hosts` file

    206.189.54.85 bos247
    ...


Tools
=====

* [hstr `hh`](https://github.com/dvorka/hstr)
* [httping](https://www.vanheusden.com/httping/)
* [brctl](https://www.thegeekstuff.com/2017/06/brctl-bridge/)
* [cssh for Mac](http://brewformulas.org/Csshx)
  * [cssh for iTerm](https://github.com/wouterdebie/i2cssh)
* [ELK config for Docker](https://github.com/docker-training/elk-dee)
* [Suse Portus - Frontend for Docker registry](http://port.us.org/)
* [TUF - A framework for securing Software Update](https://theupdateframework.github.io/)
  * [Notary](https://github.com/theupdateframework/notary)

hstr
----

Install on Ubuntu - see https://github.com/dvorka/hstr/blob/master/INSTALLATION.md#ubuntu

    sudo add-apt-repository ppa:ultradvorka/ppa
    sudo apt-get update
    sudo apt-get install hh
    hh --show-configuration >> ~/.bashrc
    source ~/.bashrc
