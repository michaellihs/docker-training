Login on CLI
============

Run

    source ./login.sh

Afterwards you can set up the following alias:

    alias ucp-api='curl -k -H "Authorization: Bearer $AUTHTOKEN"'


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
