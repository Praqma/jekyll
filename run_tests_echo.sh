#!/usr/bin/env bash

# The Set Builtin
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
[ "$DEBUG" == 'true' ] && set -x

echo "Running Echo Tests on Docker Cloud...."

# Environment Variables for Building and Testing
# https://docs.docker.com/docker-cloud/builds/advanced/#environment-variables-for-building-and-testing

echo "\$SOURCE_BRANCH: ${SOURCE_BRANCH}"
echo "\$SOURCE_COMMIT: ${SOURCE_COMMIT}"
echo "\$COMMIT_MSG: ${COMMIT_MSG}"
echo "\$DOCKER_REPO: ${DOCKER_REPO}"
echo "\$CACHE_TAG: ${CACHE_TAG}"
echo "\$IMAGE_NAME: ${IMAGE_NAME}"
