#!/usr/bin/env bash

# The Set Builtin
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
[ "$DEBUG" == 'true' ] && set -x

docker run \
  --rm \
  --tty \
  $DOCKER_IMAGE_NAME \
  bash -c " \
    jekyll --version && \
    ruby --version && \
    gem list && \
    bundle env
    "
