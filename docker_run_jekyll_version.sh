#!/usr/bin/env bash

docker run \
  --rm \
  --tty praqma/jekyll:latest \
  bash -c " \
    jekyll --version && \
    ruby --version && \
    gem list \
    "
