@echo off

docker run ^
  --rm ^
  --tty ^
  --volume $JEKYLL_SITE_DIR:/website:rw ^
  --workdir /website ^
  $DOCKER_IMAGE_NAME ^
  bash -c " ^
    ruby --version && ^
    analyze ^
      --source /website ^
      --copies /opt/static-analysis/template_report_duplication.html ^
      --unused /opt/static-analysis/template_report_usage.html
    "
