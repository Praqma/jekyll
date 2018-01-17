FROM ruby:2.5.0-alpine

LABEL author="Praqma <info@praqma.com>"
LABEL maintainer="Praqma <info@praqma.com>"

# 1. Install github-pages gems.
# https://github.com/github/pages-gem
# https://pages.github.com/versions/

RUN apk add --no-cache --virtual .build_deps \
    ruby-dev build-base && \
    gem install github-pages --version 172 &&\
    apk del .build_deps

# 2. Install Static Analysis tools.

RUN mkdir -p /opt/static-analysis

COPY analyze.rb /opt/static-analysis

COPY template_report_duplication.html /opt/static-analysis
COPY template_report_duplication_junit.xml /opt/static-analysis

COPY template_report_usage.html /opt/static-analysis
COPY template_report_usage_junit.xml /opt/static-analysis

RUN chmod +x /opt/static-analysis/analyze.rb
RUN ln -s /opt/static-analysis/analyze.rb /usr/bin/analyze

# 3. Install Docker client.

ENV VER="17.12.0-ce"
RUN apk --no-cache add curl git openssh
RUN curl -L -o /tmp/docker-$VER.tgz \
  https://download.docker.com/linux/static/stable/x86_64/docker-$VER.tgz && \
  tar -xz -C /tmp -f /tmp/docker-$VER.tgz && \
  mv /tmp/docker/* /usr/bin

# 4. Install aws-cli package.
# Pinned to 1.11.18 to avoid dependency on python-dev package.

RUN set -x && \
  apk add --update --no-cache \
     bash \
     groff \
     jq \
     less \
     py-pip && \
  pip install --upgrade pip && \
  pip install awscli==1.11.18

# The EXPOSE instruction does not actually publish the port.
# https://docs.docker.com/engine/reference/builder/#expose
# It functions as a type of documentation between the person who builds
#   the image and the person who runs the container, about which ports
#   are intended to be published.
# To actually publish the port when running the container, use the -p flag
#   on docker run to publish and map one or more ports, or the -P flag to
#   publish all exposed ports and map them to high-order ports.

EXPOSE 4000
