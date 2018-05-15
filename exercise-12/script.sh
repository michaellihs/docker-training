docker network ls
docker network inspect bridge
ip a
apt-get install bridge-utils
brctl show docker0
docker container run --name u1 -dt centos:7
docker network inspect bridge
ip a
brctl show docker0
docker container exec -it u1 bash
docker network create --driver bridge my_bridge
docker container run --name=u2 --network=my_bridge -dt centos:7
docker container inspect u2
docker container run centos:7 ping u1
docker container exec u2 ping 172.18.0.2
docker container exec u2 ping 172.17.0.3
docker network connect my_bridge u1
docker container inspect u1
docker container exec u2 ping 172.18.0.3
