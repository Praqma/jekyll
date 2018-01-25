@echo off

if "%DOCKER_IMAGE_NAME%"=="" (
  echo %%DOCKER_IMAGE_NAME%% was not defined.
  set DOCKER_IMAGE_NAME=praqma/jekyll:latest
)
echo %%DOCKER_IMAGE_NAME%%: %DOCKER_IMAGE_NAME%

docker build ^
  --tag %DOCKER_IMAGE_NAME% ^
  --file Dockerfile ^
  .
