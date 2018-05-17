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


ucp-api "https://${UCP_FQDN}/containers/json" | jq
touch mysecret
ucp-api --data '{"Data":"'$(base64 mysecret)'","Name":"test_secret"}' -X POST "https://${UCP_FQDN}/secrets/create"
ucp-api -X DELETE "https://${UCP_FQDN}/services/phh534k2d0m5qmsoltd7cn06y"
touch myservice.json
ucp-api --data @myservice.json "https://${UCP_FQDN}/services/create"
cp myservice.json myservice-update.json

# get Version.Index and add it as ?version=298
ucp-api "https://${UCP_FQDN}/services/g00cep8t5spjdvbc9wo82qwux" | jq
ucp-api --data @myservice-update.json "https://${UCP_FQDN}/services/g00cep8t5spjdvbc9wo82qwux/update?version=298"