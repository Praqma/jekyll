FROM jekyll/jekyll

# Install Docker client.
ENV VER="17.03.0-ce"
RUN apk --no-cache add curl git openssh
RUN curl -L -o /tmp/docker-$VER.tgz https://get.docker.com/builds/Linux/x86_64/docker-$VER.tgz && \
  tar -xz -C /tmp -f /tmp/docker-$VER.tgz && \
  mv /tmp/docker/* /usr/bin

# Install aws-cli package.
# Pinned to 1.11.18 to avoid dependency on python-dev package.
RUN set -x \
  && apk add --update --no-cache \
     bash \
     groff \
     jq \
     less \
     py-pip \
  && pip install --upgrade pip \
  && pip install awscli==1.11.18
