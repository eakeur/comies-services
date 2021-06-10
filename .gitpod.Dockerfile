FROM gitpod/workspace-full-vnc

ENV ANDROID_HOME=/home/gitpod/android-sdk-linux \
    FLUTTER_HOME=/home/gitpod/flutter \
    PATH=/usr/lib/dart/bin:$FLUTTER_HOME/bin:$ANDROID_HOME/tools:$PATH

USER root

RUN curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && curl -fsSL https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list \
    && install-packages build-essential dart libkrb5-dev gcc make gradle android-tools-adb android-tools-fastboot

USER gitpod

RUN set -ex; \
    sudo apt-get update; \
    sudo apt-get install -y libglu1-mesa; \
    sudo rm -rf /var/lib/apt/lists/*

RUN set -ex; \
    git clone --depth 1 https://github.com/flutter/flutter.git -b stable --no-single-branch
    
ENV PATH="$PATH:/home/gitpod/flutter/bin"

RUN set -ex; \
    flutter upgrade; \
    flutter config --enable-web; \
    flutter precache

RUN cd /home/gitpod \
    && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r26.1.1-linux.tgz \
    && tar -xvf android-sdk.tgz && rm android-sdk.tgz
