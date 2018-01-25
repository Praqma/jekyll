#!/usr/bin/env bash

# The Set Builtin
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
[ "$DEBUG" == 'true' ] && set -x

echo ""

if [[ -z "${DOCKER_IMAGE_NAME}" ]]; then
  echo "\$DOCKER_IMAGE_NAME is not defined."
  DOCKER_IMAGE_NAME="praqma/jekyll:latest"
fi
echo "\$DOCKER_IMAGE_NAME: ${DOCKER_IMAGE_NAME}"

echo ""

docker run \
  --rm \
  --tty \
  --user $(id -u):$(id -g) \
  $DOCKER_IMAGE_NAME \
  bash -c " \
    jekyll --version && \
    ruby --version && \
    gem list && \
    bundle env
    "
