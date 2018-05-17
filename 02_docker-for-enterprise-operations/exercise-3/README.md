Login on CLI
============

Run

    source ./login.sh

Afterwards you can set up the following alias:

    alias ucp-api='curl -k -H "Authorization: Bearer $AUTHTOKEN"'

Get bundle with

    ucp-api https://${UCP_FQDN}/api/clientbundle -o bundle.zip
    unzip bundle.zip
    ./


Install `kubectl` on Mac
========================

Run

    brew install kubectl


Run commands against API
========================

* get all containers

   ```
   ucp-api "https://${UCP_FQDN}/containers/json" | jq
   ```
