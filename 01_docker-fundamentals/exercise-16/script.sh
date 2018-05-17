docker swarm init
docker swarm init --advertise-addr 159.65.118.11
docker system info
docker node ls
docker swarm ca --rotate --cert-expiry 168h
sudo netstat -plunt
docker swarm join-token woker
docker swarm join-token worker
docker node ls
docker node ls
docker node promote bos8 bos46
docker node ls

docker swarm join --token <TOKEN> 159.65.118.11:2377