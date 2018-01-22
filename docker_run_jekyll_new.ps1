docker run `
  --rm `
  --tty `
  --volume $env:JEKYLL_SITE_DIR:/website:rw `
  --workdir /website `
  $env:DOCKER_IMAGE_NAME `
  jekyll new .