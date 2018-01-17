#!/usr/bin/env bash

docker build \
  --tag praqma/jekyll:latest \
  --file Dockerfile \
  .
