docker network ls
docker service create --name who-am-I --publish 8000:8000 --replicas 3 training/whoami:latest
curl -4 localhost:8000
curl -4 localhost:8000
curl -4 localhost:8000
curl -4 localhost:8000
curl -4 localhost:8000
curl -4 localhost:8000
curl -4 localhost:8000
curl -4 localhost:8000
docker service update who-am-I --replicas 6
for value in {1..10}; do echo -n "$(($value % 6)) "; curl -4 localhost:8000; done
docker service create --name nginx --publish 8080:80 nginx
docker service ps nginx
docker service rm $(docker service ls -q)
