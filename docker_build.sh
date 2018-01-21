#!/usr/bin/env bash

# The Set Builtin
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
[ "$DEBUG" == 'true' ] && set -x

docker build \
  --tag $DOCKER_IMAGE_NAME \
  --file Dockerfile \
  .
