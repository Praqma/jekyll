@echo off

if "%DOCKER_IMAGE_NAME%"=="" (
  echo %%DOCKER_IMAGE_NAME%% was not defined.
  set DOCKER_IMAGE_NAME=praqma/jekyll:latest
)
echo %%DOCKER_IMAGE_NAME%%: %DOCKER_IMAGE_NAME%

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
