ARG BASE_IMAGE=quay.io/devfile/universal-developer-image

FROM ${BASE_IMAGE}

RUN yum upgrade -y && yum -y install nss alsa-lib.x86_64 atk.x86_64 \
    cups-libs.x86_64 gtk3.x86_64 libdrm libXcomposite.x86_64 libXcursor.x86_64 \
    libXdamage.x86_64 libXext.x86_64 libXi.x86_64 libXrandr.x86_64 libXScrnSaver.x86_64 \
    libXtst.x86_64 mesa-libgbm pango.x86_64 xorg-x11-fonts-misc xorg-x11-fonts-Type1  && \
    yum update nss -y && yum clean all -y # buildkit

USER 10001