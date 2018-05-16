kubeadm init
whois 7.7.7.7
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config 
kubectl get nodes
kubectl apply -n kube-system -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
get nodes -w
kubectl get nodes -w
kubectl get nodes
kubectl get nodes
kubectl get pods -n kube-system
kubectl run nginx --image nginx
kubectl get deployments
kubectl get pods
kubectl describe pods nginx-65899c769f-mk6sw
kubectl lots deployments/nginx
kubectl logs deployments/nginx
kubectl expose deployments/nginx --port 8080 --target-port 80
kubectl get services
IP=$(kubectl get service nginx -o go-template --template '{{ .spec.clusterIP}}')
curl http://${IP}:8080
kubectl logs deployments/nginx
curl http://${IP}:8080
kubectl logs deployments/nginx
kubectl scale deployments/nginx --replicas 3
kubectl get pods -o wide -w

