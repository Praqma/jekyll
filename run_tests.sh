#!/usr/bin/env bash

# Automated Tests to be run with Docker Cloud

# The Set Builtin
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
[ "$DEBUG" == 'true' ] && set -x

CURRENT_PWD=${PWD}
JEKYLL_SITE_DIR=$(PWD)/website

echo "Running Tests on Docker Cloud...."

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
COLORLESS='\033[0m'

echo -e "${ORANGE}Tests initiated.${COLORLESS}"

echo -e "${BLUE}Show versions....${COLORLESS}"

jekyll --version && \
ruby --version && \
gem list && \
bundle env

echo -e "${BLUE}Making new website directory....${COLORLESS}"

mkdir $JEKYLL_SITE_DIR && cd $JEKYLL_SITE_DIR

echo -e "${BLUE}Create website....${COLORLESS}"

jekyll new .

echo -e "${BLUE}Build website....${COLORLESS}"

jekyll build

echo -e "${BLUE}Show analyze option....${COLORLESS}"

analyze --help

echo -e "${BLUE}Analyze website....${COLORLESS}"

analyze \
  --source ${JEKYLL_SITE_DIR} \
  --copies /opt/static-analysis/template_report_duplication.html \
  --unused /opt/static-analysis/template_report_usage.html \

if [[ -f analyzed_report_duplication.xml && -f analyzed_report_unused.xml ]]; then
  cat analyzed_report_*
  exit 0
else
  exit 42
fi

echo -e "${ORANGE}Tests completed.${COLORLESS}"