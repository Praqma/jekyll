#!/usr/bin/env bash

# Automated Tests on Docker Cloud
# Script can be used locally. BEWARE that $JEKYLL_SITE_DIR will be PURGED!

# The Set Builtin
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
[ "$DEBUG" == 'true' ] && set -x

echo "Running Tests on Docker Cloud...."

source .environment

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
COLORLESS='\033[0m'

echo -e "${ORANGE}Tests initiated.${COLORLESS}"

echo -e "${BLUE}Build Docker image....${COLORLESS}"

echo $DOCKER_IMAGE_NAME_AUTOTEST

docker build \
  --tag $DOCKER_IMAGE_NAME_AUTOTEST \
  --file Dockerfile \
  .

echo -e "${BLUE}Switching to \$JEKYLL_SITE_DIR ${JEKYLL_SITE_DIR}....${COLORLESS}"

CURRENT_PWD=${PWD}

if [ -d "${JEKYLL_SITE_DIR}" ]; then
  # Control will enter here if $JEKYLL_SITE_DIR exists.
  echo -e "The ${BLUE}\$JEKYLL_SITE_DIR${COLORLESS} (${JEKYLL_SITE_DIR}) ${ORANGE}already${COLORLESS} exists."
else
  # Control will enter here if $JEKYLL_SITE_DIR does not exist.
  echo -e "The ${BLUE}\$JEKYLL_SITE_DIR${COLORLESS} (${JEKYLL_SITE_DIR}) does ${GREEN}not${COLORLESS} exist."
fi

echo -e "${BLUE}Show versions....${COLORLESS}"

docker run \
  --rm \
  --tty \
  $DOCKER_IMAGE_NAME_AUTOTEST \
  bash -c " \
    jekyll --version && \
    ruby --version && \
    gem list && \
    bundle env
    "

echo -e "${BLUE}Create website....${COLORLESS}"

docker run \
  --rm \
  --tty \
  --volume $JEKYLL_SITE_DIR:/website:rw \
  --workdir /website \
  $DOCKER_IMAGE_NAME_AUTOTEST \
  bash -c " \
    jekyll new . \
    "

echo -e "${BLUE}Build website....${COLORLESS}"

docker run \
  --interactive \
  --rm \
  --tty \
  --volume $JEKYLL_SITE_DIR:/website:rw \
  --workdir /website \
  $DOCKER_IMAGE_NAME_AUTOTEST \
  jekyll build

echo -e "${BLUE}Show analyze option....${COLORLESS}"

docker run \
  --rm \
  --tty \
  $DOCKER_IMAGE_NAME_AUTOTEST \
  analyze --help

echo -e "${BLUE}Analyze website....${COLORLESS}"

docker run \
  --rm \
  --tty \
  --volume $JEKYLL_SITE_DIR:/website:rw \
  --workdir /website \
  $DOCKER_IMAGE_NAME_AUTOTEST \
  bash -c " \
    analyze \
      --source /website \
      --copies /opt/static-analysis/template_report_duplication.html \
      --unused /opt/static-analysis/template_report_usage.html \
      && \
      if [[ -f analyzed_report_duplication.xml && -f analyzed_report_unused.xml ]]; then
        cat analyzed_report_*
        exit 0
      else
        exit 42
      fi
    "

echo -e "${ORANGE}Tests completed.${COLORLESS}"