docker volume create --name test1
docker volume ls
docker container run -it -v test1:/www/website centos:7 bash
docker volume rm test1
docker ps
docker container ls
docker container rm -f c3aa70f94472 51c5ae319806
docker volume rm test1

docker volume create nginx_logs
mkdir ~/public_html
docker container run -d -P --name nginx_server -v ~/public_html:/usr/share/nginx/html -v nginx_logs:/var/log/nginx training/nginx:ee2.0
docker container ls
echo "hallo welt" > ~/public_html/index.html
curl http://localhost:32768
docker container exec -it nginx_server bash
curl http://localhost:32768
docker container exec -it nginx_server bash
