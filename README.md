# Jekyll

[![GitHub Watchers](https://img.shields.io/github/watchers/praqma/jekyll.svg)](https://github.com/praqma/jekyll/watchers)
[![GitHub Stars](https://img.shields.io/github/stars/praqma/jekyll.svg)](https://github.com/praqma/jekyll/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/praqma/jekyll.svg)](https://github.com/praqma/jekyll/network)
[![GitHub Issues](https://img.shields.io/github/issues/praqma/jekyll.svg)](https://github.com/praqma/jekyll/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/praqma/jekyll.svg)](https://github.com/praqma/jekyll/pulls)
[![GitHub Tags](https://img.shields.io/github/tag/praqma/jekyll.svg)](https://github.com/praqma/jekyll/tags)
[![GitHub Releases](https://img.shields.io/github/release/praqma/jekyll.svg)](https://github.com/praqma/jekyll/releases)
[![GitHub Contributors](https://img.shields.io/github/contributors/praqma/jekyll.svg)](https://github.com/praqma/jekyll/graphs/contributors)
[![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/praqma/jekyll/blob/master/LICENSE)

[![Docker Stars](https://img.shields.io/docker/stars/praqma/jekyll.svg)](https://hub.docker.com/r/praqma/jekyll/)
[![Docker Pulls](https://img.shields.io/docker/pulls/praqma/jekyll.svg)](https://cloud.docker.com/app/praqma/repository/docker/praqma/jekyll/general)
[![Docker Automated Build](https://img.shields.io/docker/automated/praqma/jekyll.svg)](https://cloud.docker.com/app/praqma/repository/docker/praqma/jekyll/builds)
[![Docker Build Status](https://img.shields.io/docker/build/praqma/jekyll.svg)](https://cloud.docker.com/app/praqma/repository/docker/praqma/jekyll/builds)

[![GitHub Release Date](https://img.shields.io/github/release-date/praqma/jekyll.svg)](https://github.com/Praqma/jekyll/releases)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/praqma/jekyll.svg)](https://github.com/Praqma/jekyll/commits/master)
[![GitHub Code Size in Bytes](https://img.shields.io/github/languages/code-size/praqma/jekyll.svg)](https://github.com/Praqma/jekyll)
[![GitHub Repository Size in Bytes](https://img.shields.io/github/repo-size/praqma/jekyll.svg)](https://github.com/Praqma/jekyll)

Docker built Jekyll image for building Praqma's website.

See [jekyll](https://github.com/praqma/jekyll) repository on GitHub.

See [jekyll](https://hub.docker.com/r/praqma/jekyll/) repository on Docker Hub.

See [jekyll](https://cloud.docker.com/app/praqma/repository/docker/praqma/jekyll/) repository on Docker Cloud.

## History

A long time ago in a galaxy far, far away....

Praqma's website was published directly on GitHub Pages. Therefore, we use a Docker built Jekyll image that resembles implementation of GitHub Pages in order to test our commits before publishing them.

This image has originated from obsolete [docker-gh-pages](https://github.com/praqma/docker-gh-pages) repository and obsolete [gh-pages](https://hub.docker.com/r/praqma/gh-pages/) image.

GitHub Pages list the [dependencies and versions](https://pages.github.com/versions/) of Jekyll, Liquid, KramDown etc. on their production system. The information are also [available](https://pages.github.com/versions.json) in JSON format.

This repository aims to provide a Docker image that resembles GitHub Pages. We expect that our tested pages against this image will behave in the same manner after published to GitHub Pages. It contains [pages-gem](https://github.com/github/pages-gem) for Ruby, which is maintained by GitHub. The [pages-gem](https://github.com/github/pages-gem) is always up to date with the dependencies and versions running live on GitHub Pages.

Since then, we have moved our website to the cloud....

## Prerequisites

### Get the Website

Clone a Jekyll based website from the Internet at the same parent directory level of this repository.

Using `praqma.com` directory as an example. You should have similar directory structure shown below.

```
$ tree -d -L 1
.
├── jekyll
└── praqma.com
```

To create new Jekyll based website, use [docker_run_jekyll_new.sh](https://github.com/Praqma/jekyll/blob/master/docker_run_jekyll_new.sh) script.

### Get the Image

Pull the image from Docker.

```
docker pull praqma/jekyll:latest
```

As an alternative, build the image locally. Build locally (or use [docker_build.sh](https://github.com/Praqma/jekyll/blob/master/docker_build.sh) script):

```
docker build --tag praqma/jekyll:latest .
```

### Use Scripts Locally

Scripts source [.environment](https://github.com/Praqma/jekyll/blob/master/.environment) file to use its default environment variables.

Modify local `.environment` file if its environment variables should be different.

Optionally, set `DEBUG=1` in terminal before using the scripts if commands to be displayed prior to execution.

## Getting Started

### Check the Versions

Check the version of `jekyll` gem:

```
source .environment; \
docker run \
  --rm \
  --tty \
  $DOCKER_IMAGE_NAME_LATEST \
  jekyll --version
```

Use [docker_run_jekyll_version.sh](https://github.com/Praqma/jekyll/blob/master/docker_run_jekyll_version.sh) script to show versions of Jekyll, Ruby and its gems.

### Serve with Jekyll

Mount the website's source directory into the container and serve it using `jekyll` gem or use [docker_run_jekyll_serve.sh](https://github.com/Praqma/jekyll/blob/master/docker_run_jekyll_serve.sh) script.

```
source .environment; \
docker run \
  --interactive \
  --rm \
  --tty \
  --volume $JEKYLL_SITE_DIR:/website:rw \
  --workdir /website \
  --publish 4444:4000 \
  $DOCKER_IMAGE_NAME_LATEST \
  jekyll serve --watch --host 0.0.0.0
```

The website is now being served on http://localhost:4444/.

### Analyze the Website

The image also analyze the website for duplicated and unused resources. It generates JUnit XML files as output, which can be parsed by other tools.

Run locally directly from this repository:

```
source .environment; \
ruby analyze.rb --source $JEKYLL_SITE_DIR
```

Run from Docker container (or use [docker_run_analyze.sh](https://github.com/Praqma/jekyll/blob/master/docker_run_analyze.sh) script):

```
source .environment; \
docker run \
--rm \
--tty \
--volume $JEKYLL_SITE_DIR:/website:rw \
--workdir /website \
$DOCKER_IMAGE_NAME_LATEST \
analyze \
  --source /website \
  --copies /opt/static-analysis/template_report_duplication.html \
  --unused /opt/static-analysis/template_report_usage.html
```

Both of these commands will produce two reports in the current working directory.

Use `ruby analyze.rb --help` command to view the complete list of available analyze options.