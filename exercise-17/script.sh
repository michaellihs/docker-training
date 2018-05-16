docker node update --label-add datacenter=east bos5
docker node update --label-add datacenter=east bos8
docker node update --label-add datacenter=west bos46
docker node update --label-add datacenter=west bos52
docker service create --name my_proxy --replicas=2 --publish 8000:80 --placement-pref spread=node.labels.datacenter nginx
docker service update pinger --read-only
docker service create --entrypoint "ping 8.8.8.8" alpine
docker service create --detach=false --replicas 5 busybox top
docker service ps
docker service ps pinger
docker service rm $(docker service ls -q)
docker service ps pinger
docker service ls
