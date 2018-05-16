docker container run -d nginx
docker container ls
docker container inspect e0f12140bcbf
ping 172.17.0.4
curl http://172.17.0.4:80
docker container kill e0f12140bcbf
docker container run -d -p 5000:80 nginx
curl http://localhost:5000
docker container ls
docker container port aac042c5cab1

docker image build -t my-nginx .
docker container run -d -P my-nginx
docker container port 76bb4e1403b8e2d08d17db2aa14e51f3ee61a5cc5d9750120236cac1b45bc85f
curl localhost:32769
