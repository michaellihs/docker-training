Docker Training - 2018-05-15
============================

Transcript of Docker Fundamentals and Docker Enterprise Operations training 2018-05-15 - 2018-05-19.

* [First Part: Docker Fundamentals](01_docker-fundamentals/README.md)
* [Second Part: Docker for Enterprise Operations](02_docker-for-enterprise-operations/README.md)


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
