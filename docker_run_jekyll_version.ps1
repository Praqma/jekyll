if (-Not (Get-Variable DOCKER_IMAGE_NAME -Scope Global -ErrorAction SilentlyContinue)) {
  Write-Host "`$env:DOCKER_IMAGE_NAME was not defined."
  $env:DOCKER_IMAGE_NAME = "praqma/jekyll:latest"
}
Write-Host "`$env:DOCKER_IMAGE_NAME: $env:DOCKER_IMAGE_NAME"

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
