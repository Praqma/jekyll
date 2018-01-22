docker run `
  --rm `
  --tty `
  $env:DOCKER_IMAGE_NAME `
  bash -c " `
    jekyll --version && `
    ruby --version && `
    gem list && `
    bundle env `
    "
