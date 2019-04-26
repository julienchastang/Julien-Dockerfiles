#!/usr/bin/bash

EMACS_VERSION=26.2

sed -i 's/# deb/deb/g' /etc/apt/sources.list

apt-get update && apt install -y build-essential wget

apt-get build-dep -y emacs25

cd /tmp

wget https://mirror.clarkson.edu/gnu/emacs/emacs-${EMACS_VERSION}.tar.xz

tar xvf emacs-${EMACS_VERSION}.tar.xz && cd emacs-${EMACS_VERSION}

./configure --with-modules && make && make install


