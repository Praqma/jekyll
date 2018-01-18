#!/usr/bin/env bash

# The Set Builtin
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
[ "$DEBUG" == 'true' ] && set -x

source .environment

docker build \
  --tag $DOCKER_IMAGE_NAME_LATEST \
  --file Dockerfile \
  .
