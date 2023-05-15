FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy-version-f70266cb

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    at \
    zip \
    unzip \
    openssh-server \
    openssh-client \
    openssh-sftp-server \
    logrotate \
    nano \
    netcat-openbsd \
    sudo \
    libfontconfig1 \
    libfreetype6 \
    libssl3 && \
  echo "**** cleanup ****" && \
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
  export SDKMAN_DIR="/usr/local/sdkman" && \
  curl -s "https://get.sdkman.io" | bash && \
  source "/usr/local/sdkman/bin/sdkman-init.sh" && \
  echo 'export SDKMAN_DIR="/usr/local/sdkman" && source "/usr/local/sdkman/bin/sdkman-init.sh"' >> /etc/profile && \
  sdk install java 20-amzn && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*


# add local files
COPY /root /

EXPOSE 2222

VOLUME /config
