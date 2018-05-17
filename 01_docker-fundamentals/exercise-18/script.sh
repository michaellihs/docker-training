docker service create --replicas 4
docker service create --replicas 4 --name myProxy nginx
watch docker service ps myProxy
docker service rm $(docker service ls -q)
