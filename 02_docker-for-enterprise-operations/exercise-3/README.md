Login on CLI
============

Run

    source ./login.sh

Get bundle with

    ucp-api https://${UCP_FQDN}/api/clientbundle -o bundle.zip
    unzip bundle.zip
    eval "$(<env.sh)"


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
