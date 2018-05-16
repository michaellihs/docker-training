echo 'abc1234' | docker secret create my-secret -
docker secret ls
docker secret inspect my-secret
docker service create --name demo --secret my-secret alpine:latest ping 8.8.8.8
docker container ls
docker container exec -it 28640d8340f4 sh
vi app.py
vi Dockerfile
docker image build -t michaellihs/secrets-demo:1.0 .
docker image push michaellihs/secrets-demo:1.0
docker service create --name secrets-demo --replicas=1 --secret source=my-secret,target=/custom/path/password,mode=0400 -e USERNAME="jdoe" -e PASSWORD_FILE="/custom/path/password" michaellihs/secrets-demo:1.0
docker container ps
docker container exec -it 28640d8340f4 sh
docker service ls
docker service ps secrets-demo

echo "jdoe" > username
echo "my-pass" > password
kubectl create secret generic user-pass --from-file=./username --from-file=./password
vi secretpod.yaml
kubectl create -f secretpod.yaml
kubectl get pods
kubectl describe pods secretpod
kubectl exec -it secretpod bash

