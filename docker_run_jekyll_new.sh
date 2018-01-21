#!/usr/bin/env bash

# The Set Builtin
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
[ "$DEBUG" == 'true' ] && set -x

source .environment

docker run \
  --rm \
  --tty \
  --user $(id -u):$(id -g) \
  --volume $JEKYLL_SITE_DIR:/website:rw \
  --workdir /website \
  $DOCKER_IMAGE_NAME_LATEST \
  bash -c " \
    echo \"Creating new Jekyll site....\" && \
    jekyll new . \
    "