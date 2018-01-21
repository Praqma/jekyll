#!/usr/bin/env bash

# The Set Builtin
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
[ "$DEBUG" == 'true' ] && set -x

source .environment

docker run \
  --rm \
  --tty \
  --user $(id -u):$(id -g) \
  $DOCKER_IMAGE_NAME_LATEST \
  bash -c " \
    jekyll --version && \
    ruby --version && \
    gem list && \
    bundle env
    "
