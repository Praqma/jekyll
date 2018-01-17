#!/usr/bin/env bash

docker run \
  --rm \
  --volume $(pwd)/../praqma.com:/website:rw \
  --workdir /website \
  --tty praqma/jekyll:latest \
  bash -c " \
    ruby --version && \
    analyze \
      --source /website \
      --copies /opt/static-analysis/template_report_duplication.html \
      --unused /opt/static-analysis/template_report_usage.html
    "
