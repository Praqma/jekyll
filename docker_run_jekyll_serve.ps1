docker run `
  --interactive `
  --rm `
  --tty `
  --volume $env:JEKYLL_SITE_DIR:/website:rw `
  --workdir /website `
  --publish 4444:4000 `
  $env:DOCKER_IMAGE_NAME `
  bash -c "
    bundle install && `
    jekyll --version && `
    ruby --version && `
    jekyll serve --watch --host=0.0.0.0 --incremental --unpublished --future
    "
