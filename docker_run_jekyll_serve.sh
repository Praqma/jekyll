#!/usr/bin/env bash

# The Set Builtin
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
[ "$DEBUG" == 'true' ] && set -x

source .environment

docker run \
  --interactive \
  --rm \
  --tty \
  --volume $JEKYLL_SITE_DIR:/website:rw \
  --workdir /website \
  --publish 4444:4000 \
  $DOCKER_IMAGE_NAME_LATEST \
  bash -c "
    bundle install && \
    jekyll --version && \
    ruby --version && \
    jekyll serve --watch --host 0.0.0.0
    "
