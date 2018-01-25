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
  --rm ^
  --tty ^
  --volume %JEKYLL_SITE_DIR%:/website:rw ^
  --workdir /website ^
  %DOCKER_IMAGE_NAME% ^
  bash -c " ^
    ruby --version && ^
    analyze ^
      --source /website ^
      --copies /opt/static-analysis/template_report_duplication.html ^
      --unused /opt/static-analysis/template_report_usage.html
    "
