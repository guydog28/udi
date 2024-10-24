ARG BASE_IMAGE=quay.io/devfile/universal-developer-image

FROM ${BASE_IMAGE}

USER 0 

RUN yum upgrade -y && yum -y install nss alsa-lib.x86_64 atk.x86_64 \
    cups-libs.x86_64 gtk3.x86_64 libdrm libXcomposite.x86_64 libXcursor.x86_64 \
    libXdamage.x86_64 libXext.x86_64 libXi.x86_64 libXrandr.x86_64 libXScrnSaver.x86_64 \
    libXtst.x86_64 mesa-libgbm pango.x86_64 xorg-x11-fonts-misc xorg-x11-fonts-Type1  && \
    yum update nss -y && yum clean all -y # buildkit

# Upgrade NodeJS
RUN mkdir -p /home/tooling/.nvm/
ENV NVM_DIR="/home/tooling/.nvm"
# newest 20 release
ENV NODEJS_20_VERSION=20.18.0
# newest 18 release
ENV NODEJS_18_VERSION=18.20.4
ENV NODEJS_DEFAULT_VERSION=${NODEJS_20_VERSION}
RUN source /home/user/.bashrc && \
    nvm install v${NODEJS_20_VERSION} && \
    nvm install v${NODEJS_18_VERSION} && \
    nvm alias default v${NODEJS_DEFAULT_VERSION} && nvm use v${NODEJS_DEFAULT_VERSION} && \
    npm install --global yarn@v1.22.17 &&\
    chgrp -R 0 /home/tooling && chmod -R g=u /home/tooling
ENV PATH=$NVM_DIR/versions/node/v${NODEJS_DEFAULT_VERSION}/bin:$PATH
ENV NODEJS_HOME_20=$NVM_DIR/versions/node/v${NODEJS_20_VERSION}
ENV NODEJS_HOME_18=$NVM_DIR/versions/node/v${NODEJS_18_VERSION}


USER 10001
