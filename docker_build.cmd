@echo off

docker build ^
  --tag $DOCKER_IMAGE_NAME ^
  --file Dockerfile ^
  .
