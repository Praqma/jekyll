

docker run `
  --rm `
  --tty `
  --volume $JEKYLL_SITE_DIR:/website:rw `
  --workdir /website `
  $DOCKER_IMAGE_NAME `
  jekyll new .