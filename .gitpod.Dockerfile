FROM gitpod/workspace-full-vnc:2022-12-09-04-00-52

# More information: https://www.gitpod.io/docs/config-docker/

LABEL maintainer="Michel Estermann <estermann.michel@gmail.com>"

USER root

#install qt
RUN apt-get -qq install -y --no-install-recommends software-properties-common  \
 && add-apt-repository ppa:beineri/opt-qt-5.15.2-focal \
 && apt-get update \
 && apt-get -qq install -y --no-install-recommends qt515base qt515charts-no-lgpl qt515tools \
 && apt-get -qq install -y --no-install-recommends libxcb-xinerama0-dev \
 && apt-get -qq install -y --no-install-recommends '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev \
 && apt-get -qq install -y --no-install-recommends perl \
 && apt-get clean && rm -rf /var/lib/apt/lists/*


RUN pip3 install cmake==3.27.2

# lcov and doxygen
RUN apt-get update \
 && apt-get -qq install -y --no-install-recommends lcov doxygen graphviz \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
 && apt-get -qq install -y --no-install-recommends ninja-build \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

USER gitpod

RUN pip3 install conan==1.60.2 \
 && conan profile new default --detect

# cmake-format
RUN pip3 install cmake-format==0.6.13

# pre-commit
RUN pip3 install pre-commit==3.3.3
RUN echo 'export PIP_USER=false' >> ~/.bashrc
