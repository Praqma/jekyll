@echo off

docker run ^
  --rm ^
  --tty ^
  %DOCKER_IMAGE_NAME% ^
  bash -c " ^
    jekyll --version && ^
    ruby --version && ^
    gem list && ^
    bundle env
    "
