#!/usr/bin/env bash

echo "access-example" | docker secret create access_key -
echo "secret-example" | docker secret create secret_key -