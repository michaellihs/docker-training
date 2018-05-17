cd exercise-20/orchestration-workshop/dockercoins/
docker stack deploy -c=docker-compose.yml dc
docker stack services dc
docker stack services dc
docker stack ps dc
vi docker-compose.yml 
docker stack deploy -c docker-compose.yml dc
vi docker-compose.yml 
docker stack deploy -c docker-compose.yml dc
httping -c 10 localhost:8001
httping -c 10 localhost:8002
vi docker-compose.yml 
docker stack rm dc
docker stack deploy -c=docker-compose.yml dc
vi worker/worker.py 
docker image build -t michaellihs/dockercoins_worker:1.1 worker
docker image push michaellihs/dockercoins_worker:1.1
docker service update dc_worker --image michaellihs/dockercoins_worker:1.1
vi docker-compose.yml 
docker stack deploy -c=docker-compose.yml dc
docker service udpate --update-failure-action=rollback --rollback-parallelism=2 --rollback-monitor=20s --rollback-max-failure-ratio=0.2 dc_worker
docker service udpate --update-failure-action=rollback --rollback-parallelism=2 --rollback-monitor=20s --rollback-max-failure-ratio=0.2 dc_worker
docker service update --update-failure-action=rollback --rollback-parallelism=2 --rollback-monitor=20s --rollback-max-failure-ratio=0.2 dc_worker
docker image push michaellihs/dockercoins_worker:buggy
dockerservice update dc_worker --image michaellihs/dockercoins_worker:buggy
docker service update dc_worker --image michaellihs/dockercoins_worker:buggy
docker stack ls
docker stack rm dc

