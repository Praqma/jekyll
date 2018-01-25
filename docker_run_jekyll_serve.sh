#!/usr/bin/env bash

# The Set Builtin
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
[ "$DEBUG" == 'true' ] && set -x

cat << EOF

Serve the website locally, escpecially useful for review or test.

Use \`--incremental\` to do a partial build in order to reduce regeneration time.

Unpublished posts have \`published: false\` tag.
Use \`--unpublished\` parameter to published them locally.

The filename of posts have publishing date.
Use \`--future\` parameter to publish every post, regardless of date.

EOF

echo ""

if [[ -z "${JEKYLL_SITE_DIR}" ]]; then
  echo "\$JEKYLL_SITE_DIR is not defined."
  JEKYLL_SITE_DIR="${PWD}/../praqma.com"
fi
echo "\$JEKYLL_SITE_DIR: ${JEKYLL_SITE_DIR}"

if [[ -z "${DOCKER_IMAGE_NAME}" ]]; then
  echo "\$DOCKER_IMAGE_NAME is not defined."
  DOCKER_IMAGE_NAME="praqma/jekyll:latest"
fi
echo "\$DOCKER_IMAGE_NAME: ${DOCKER_IMAGE_NAME}"

echo ""

docker run \
  --interactive \
  --rm \
  --tty \
  --user $(id -u):$(id -g) \
  --volume $JEKYLL_SITE_DIR:/website:rw \
  --workdir /website \
  --publish 4444:4000 \
  $DOCKER_IMAGE_NAME \
  bash -c "
    jekyll --version && \
    ruby --version && \
    jekyll serve --watch --host=0.0.0.0 --incremental --unpublished --future
    "