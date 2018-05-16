docker login
cd orchestration-workshop/dockercoins/
docker image build -t michaellihs/dockercoins_hasher:1.0 hasher
dockerimage push michaellihs/dockercoins_hasher:1.0
docker image push michaellihs/dockercoins_hasher:1.0
docker image build -t michaellihs/dockercoins_rng:1.0 rng
docker image push michaellihs/dockercoins_rng:1.0
docker image build -t michaellihs/dockercoins_worker:1.0 worker
docker image push michaellihs/dockercoins_worker:1.0
docker image build -t michaellihs/dockercoins_webui:1.0 webui
docker image push michaellihs/dockercoins_webui:1.0
vi docker-compose.yml 
docker-compose up
docker-compose up -d
docker-compose ps
docker container run -d michaellihs/dockercoins_rng:1.0
docker container ls
docker-compose ps
docker-compose ps
cd workspace/exercise-14/orchestration-workshop/dockercoins
docker-compose ps
docker-compose logs
