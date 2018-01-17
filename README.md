# Jekyll

[![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/praqma/jekyll/blob/master/LICENSE)

Docker built Jekyll image for building Praqma's website.

See [jekyll](https://github.com/praqma/jekyll) repository on GitHub.

See [jekyll](https://hub.docker.com/r/praqma/jekyll/) image on Docker Hub.

## History

A long time ago in a galaxy far, far away....

Praqma's website was published directly on GitHub Pages. Therefore, we use a Docker built Jekyll image that resembles implementation of GitHub Pages in order to test our commits before publishing them.

This image has originated from obsolete [docker-gh-pages](https://github.com/praqma/docker-gh-pages) repository and obsolete [gh-pages](https://hub.docker.com/r/praqma/gh-pages/) image.

GitHub Pages list the [dependencies and versions](https://pages.github.com/versions/) of Jekyll, Liquid, KramDown etc. on their production system. The information are also [available](https://pages.github.com/versions.json) in JSON format.

This repository aims to provide a Docker image that resembles GitHub Pages. We expect that our tested pages against this image will behave in the same manner after published to GitHub Pages. It contains [pages-gem](https://github.com/github/pages-gem) for Ruby, which is maintained by GitHub. The [pages-gem](https://github.com/github/pages-gem) is always up to date with the dependencies and versions running live on GitHub Pages.

Since then, we have moved our website to the cloud....

## Prerequisites


### Get the Website

Get or clone the source of a Jekyll based website at the same parent directory level of this repository.

```
$ tree -d -L 1
.
├── jekyll
└── praqma.com
```

### Get the Image

Build or pull the image.

Build locally (or use [docker_build.sh](docker_build.sh) script):

```
docker build --tag praqma/jekyll:latest .
```

## Getting Started
### Check the Versions

Check the version of `jekyll` gem:

```
docker run \
  --rm \
  --tty praqma/jekyll:latest \
  jekyll --version
```

Use [docker_run_jekyll_version.sh](docker_run_jekyll_version.sh) script to show versions of Jekyll, Ruby and its gems.

### Serve with Jekyll

Mount the website's source directory into the container and serve it using `jekyll` gem or use [docker_run_jekyll_serve.sh](docker_run_jekyll_serve.sh) script.

```
docker run \
  --interactive \
  --tty \
  --volume $(pwd)/../praqma.com:/website \
  --workdir /website \
  --publish 4444:4000 \
  praqma/jekyll:latest \
  jekyll serve --watch --host 0.0.0.0
```

The website is now being served on http://localhost:4444/.

### Analyze the Website

The image also analyze the website for duplicated and unused resources. It generates JUnit XML files as output, which can be parsed by other tools.

Run locally directly from this repository:

```
ruby analyze.rb --source $(pwd)/../praqma.com
```

Run from Docker container (or use [docker_run_analyze.sh](docker_run_analyze.sh) script):

```
docker run \
  --rm \
  --volume $(pwd)/../praqma.com:/website:rw \
  --workdir /website \
  --tty praqma/jekyll:latest \
  analyze \
	--source /website \
	--copies /opt/static-analysis/template_report_duplication.html \
	--unused /opt/static-analysis/template_report_usage.html
```

Both of these commands will produce two reports in the current working directory.

The complete list of available analyze options is available with `ruby analyze.rb --help` command.