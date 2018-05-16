kubectl run redis --image redis
export USER="michaellihs"
for DEPLOYMENT in hasher rng webui worker; do kubectl run $DEPLOYMENT --image=${USER}/dockercoins_${DEPLOYMENT}:1.0; done
kubectl get pods -o wide -w
kubectl logs deploy/rng
kubectl logs deploy/worker
kubectl expose deployment redis --port 6379
kubectl expose deployment rng --port 80
kubectl expose deployment hasher --port 80
kubectl logs deploy/worker
kubectl get services -o wide
kubectl expose deploy/webui --type=NodePort --port=80
kubectl get services -o wide
curl localhost:30543/index.html
ifconfig
kubectl scale deploy/worker replicas=10
kubectl scale deploy/worker --replicas=10
kubectl get deploy/rng -o yaml --export > deploy-rng.yaml
vi deploy-rng.yaml
kubectl apply -f deploy-rng.yaml
kubectl get daemonset
kubectl get all
kubectl delete deploy/rng
for D in redis hasher rng webui; do kubectl delete svc/$D; done
for D in redis hasher webui worker; do kubectl delete deploy/$D; done
kubectl delete ds/rng
kubectl get all
