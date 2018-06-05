FROM ruby:2.5.0

LABEL author="Praqma <info@praqma.com>"
LABEL maintainer="Praqma <info@praqma.com>"

# 0. Install AWS client

# Pinned to 1.11.18 to avoid dependency on python-dev package.


RUN apt-get update
RUN apt-get install -y python-pip
RUN pip install --upgrade pip
RUN pip install awscli==1.11.18

# 1. Install github-pages gems.
# https://github.com/github/pages-gem
# https://pages.github.com/versions/

RUN gem install \
      github-pages \
      jekyll-responsive-image

# 2. Install Static Analysis tools.

RUN mkdir -p /opt/static-analysis

COPY analyze.rb /opt/static-analysis

COPY template_report_duplication.html /opt/static-analysis
COPY template_report_duplication_junit.xml /opt/static-analysis

COPY template_report_usage.html /opt/static-analysis
COPY template_report_usage_junit.xml /opt/static-analysis

RUN chmod +x /opt/static-analysis/analyze.rb && \
  ln -s /opt/static-analysis/analyze.rb /usr/bin/analyze

# 3. Install Docker client.

RUN apt-get update
RUN apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88

RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian jessie stable"

RUN apt-get update && apt-get install -y docker-ce




# 5. Install test scripts for Docker Cloud.

RUN mkdir -p /opt/docker-autotest
COPY run_tests.sh /opt/docker-autotest
RUN chmod +x /opt/docker-autotest/run_tests.sh && \
  ln -s /opt/docker-autotest/run_tests.sh /usr/bin/run_tests

# The EXPOSE instruction does not actually publish the port.
# https://docs.docker.com/engine/reference/builder/#expose
# It functions as a type of documentation between the person who builds
#   the image and the person who runs the container, about which ports
#   are intended to be published.
# To actually publish the port when running the container, use the -p flag
#   on docker run to publish and map one or more ports, or the -P flag to
#   publish all exposed ports and map them to high-order ports.

EXPOSE 4000

# Liquid must run in UTF-8 env to support BOM characters
RUN apt-get update && \
    apt-get install -y locales && \
    echo "en_US UTF-8" > /etc/locale.gen && \
    locale-gen en_US UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_CTYPE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
