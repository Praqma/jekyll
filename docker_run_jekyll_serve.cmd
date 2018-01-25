@echo off

if "%JEKYLL_SITE_DIR%"=="" (
  echo %%JEKYLL_SITE_DIR%% was not defined.
  set JEKYLL_SITE_DIR=%CD%\..\praqma.com
)
echo %%JEKYLL_SITE_DIR%%: %JEKYLL_SITE_DIR%

if "%DOCKER_IMAGE_NAME%"=="" (
  echo %%DOCKER_IMAGE_NAME%% was not defined.
  set DOCKER_IMAGE_NAME=praqma/jekyll:latest
)
echo %%DOCKER_IMAGE_NAME%%: %DOCKER_IMAGE_NAME%

docker run ^
  --interactive ^
  --rm ^
  --tty ^
  --volume %JEKYLL_SITE_DIR%:/website:rw ^
  --workdir /website ^
  --publish 4444:4000 ^
  %DOCKER_IMAGE_NAME% ^
  bash -c "
    bundle install && ^
    jekyll --version && ^
    ruby --version && ^
    jekyll serve --watch --host=0.0.0.0 --incremental --unpublished --future
    "
