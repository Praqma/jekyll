#!/usr/bin/env bash

docker run \
  --interactive \
  --tty \
  --volume $(pwd)/../praqma.com:/website \
  --workdir /website \
  --publish 4444:4000 \
  praqma/jekyll \
  bash -c " \
    jekyll --version && \
    ruby --version && \
    jekyll serve --watch --host 0.0.0.0
    "
