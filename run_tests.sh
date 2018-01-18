#!/usr/bin/env bash

# Automated Tests to be run with Docker Cloud

# The Set Builtin
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
[ "$DEBUG" == 'true' ] && set -x

JEKYLL_SITE_DIR=/website

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
COLORLESS='\033[0m'

echo -e "${BLUE}Running Tests on Docker Cloud....${COLORLESS}"

# Environment Variables for Building and Testing
# https://docs.docker.com/docker-cloud/builds/advanced/#environment-variables-for-building-and-testing

echo "\$SOURCE_BRANCH: ${SOURCE_BRANCH}"
echo "\$SOURCE_COMMIT: ${SOURCE_COMMIT}"
echo "\$COMMIT_MSG: ${COMMIT_MSG}"
echo "\$DOCKER_REPO: ${DOCKER_REPO}"
echo "\$CACHE_TAG: ${CACHE_TAG}"
echo "\$IMAGE_NAME: ${IMAGE_NAME}"

echo -e "${ORANGE}Tests initiated.${COLORLESS}"

echo -e "${ORANGE}Show versions....${COLORLESS}"

jekyll --version && \
ruby --version && \
gem list && \
bundle env

echo -e "${ORANGE}Making new website directory....${COLORLESS}"

mkdir -v $JEKYLL_SITE_DIR && cd $JEKYLL_SITE_DIR

echo -e "${ORANGE}Create website....${COLORLESS}"

jekyll new .

echo -e "${ORANGE}Build website....${COLORLESS}"

jekyll build

echo -e "${ORANGE}Show analyze option....${COLORLESS}"

analyze --help

echo -e "${ORANGE}Analyze website....${COLORLESS}"

analyze \
  --source ${JEKYLL_SITE_DIR} \
  --copies /opt/static-analysis/template_report_duplication.html \
  --unused /opt/static-analysis/template_report_usage.html

if [[ -f analyzed_report_duplication.xml && -f analyzed_report_unused.xml ]]; then
  cat analyzed_report_*
  exit 0
else
  exit 42
fi

echo -e "${ORANGE}Tests completed.${COLORLESS}"