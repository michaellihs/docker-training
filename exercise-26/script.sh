docker system info
docker container prune --help
docker system prune --help
docker system prune
docker system prune -f
docker container run --label apple --name fuji -d alpine
docker container run --label orange --name clementine -d alpine
docker container ls -a
docker container prune --filter 'label=apple'
docker container ps -a
TIMESTAMP=$(date --rfc-3339=seconds | sed 's/ /T/')
docker container run --label tomato --name beefsteak -d alpine
docker container prune -f --filter "until=$TIMESTAMP"
docker container ls -a

