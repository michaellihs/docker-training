ucp-api https://${UCP_FQDN}/api/clientbundle -o bundle.zip
unzip bundle.zip
eval "$(<env.sh)"
docker container ls
docker volume create bundle-vol
docker volume ls
touch pod.yml
brew install kubectl
kubectl
kubectl create -f pod.yml
curl -s --cacert ./ca.pem --key ./key.pem --cert ./cert.pem https://${UCP_FQDN}:6443/api/v1/pods