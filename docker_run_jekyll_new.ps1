if (-Not (Get-Variable JEKYLL_SITE_DIR -Scope Global -ErrorAction SilentlyContinue)) {
  Write-Host "`$env:JEKYLL_SITE_DIR was not defined."
  $env:JEKYLL_SITE_DIR = "$PWD\..\praqma.com"
}
Write-Host "`$env:JEKYLL_SITE_DIR: $env:JEKYLL_SITE_DIR"

if (-Not (Get-Variable DOCKER_IMAGE_NAME -Scope Global -ErrorAction SilentlyContinue)) {
  Write-Host "`$env:DOCKER_IMAGE_NAME was not defined."
  $env:DOCKER_IMAGE_NAME = "praqma/jekyll:latest"
}
Write-Host "`$env:DOCKER_IMAGE_NAME: $env:DOCKER_IMAGE_NAME"

docker run `
  --rm `
  --tty `
  --volume $env:JEKYLL_SITE_DIR:/website:rw `
  --workdir /website `
  $env:DOCKER_IMAGE_NAME `
  jekyll new .