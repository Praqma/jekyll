@echo off

docker run ^
  --interactive ^
  --rm ^
  --tty ^
  --volume $JEKYLL_SITE_DIR:/website:rw ^
  --workdir /website ^
  --publish 4444:4000 ^
  $DOCKER_IMAGE_NAME ^
  bash -c "
    bundle install && ^
    jekyll --version && ^
    ruby --version && ^
    jekyll serve --watch --host 0.0.0.0
    "
