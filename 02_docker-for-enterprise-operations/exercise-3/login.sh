#!/usr/bin/env bash

export UCP_FQDN="206.189.54.85"
export AUTHTOKEN=$(curl -sk -d '{"username":"admin","password":"adminadmin"}' https://${UCP_FQDN}/auth/login | jq -r .auth_token)
echo "AUTHTOKEN: ${AUTHTOKEN}"
alias ucp-api='curl -k -H "Authorization: Bearer $AUTHTOKEN"'

ucp-api https://${UCP_FQDN}/api/clientbundle -o bundle.zip
unzip bundle.zip
eval "$(<env.sh)"