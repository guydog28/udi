ARG BASE_IMAGE=quay.io/devfile/universal-developer-image

FROM ${BASE_IMAGE}

USER 0 

RUN yum upgrade -y && yum -y install nss alsa-lib.x86_64 atk.x86_64 \
    cups-libs.x86_64 gtk3.x86_64 libdrm libXcomposite.x86_64 libXcursor.x86_64 \
    libXdamage.x86_64 libXext.x86_64 libXi.x86_64 libXrandr.x86_64 libXScrnSaver.x86_64 \
    libXtst.x86_64 mesa-libgbm pango.x86_64 xorg-x11-fonts-misc xorg-x11-fonts-Type1  && \
    yum update nss -y && yum clean all -y # buildkit

USER 10001

ENV HOME=/home/tooling

# Upgrade NodeJS
ENV OLD_NODEJS_18_VERSION=${NODEJS_18_VERSION}
ENV OLD_NODEJS_20_VERSION=${NODEJS_20_VERSION}

RUN source /home/user/.bashrc && \
    nvm install v18 && \
    nvm install v20 && \
    nvm install v22 && \
    nvm alias default v22 && nvm use v22 && \
    nvm uninstall v${OLD_NODEJS_20_VERSION} && \
    nvm uninstall v${OLD_NODEJS_18_VERSION} 
RUN set N18 = $(nvm version v18)
RUN set N20 = $(nvm version v20)
RUN set N22 = $(nvm version v22)
ENV NODEJS_22_VERSION=$N22
ENV NODEJS_20_VERSION=$N20
ENV NODEJS_18_VERSION=$N18
ENV NODEJS_DEFAULT_VERSION=${NODEJS_22_VERSION}
ENV PATH=$NVM_DIR/versions/node/v${NODEJS_DEFAULT_VERSION}/bin:$PATH
ENV NODEJS_HOME_22=$NVM_DIR/versions/node/v${NODEJS_22_VERSION}
ENV NODEJS_HOME_20=$NVM_DIR/versions/node/v${NODEJS_20_VERSION}
ENV NODEJS_HOME_18=$NVM_DIR/versions/node/v${NODEJS_18_VERSION}

ENV HOME=/home/user
