#!/usr/bin/bash

# https://gist.github.com/katopz/8b766a5cb0ca96c816658e9407e83d00

ZMQ_VERSION=4.3.1

# Download zeromq
# Ref http://zeromq.org/intro:get-the-software
wget https://github.com/zeromq/libzmq/releases/download/v${ZMQ_VERSION}/zeromq-${ZMQ_VERSION}.tar.gz

# Unpack tarball package
tar xvzf zeromq-${ZMQ_VERSION}.tar.gz

# Install dependency
apt-get update && \
apt-get install -y libtool pkg-config build-essential autoconf automake uuid-dev

# Create make file
cd zeromq-${ZMQ_VERSION}
./configure

# Build and install(root permission only)
make install

# Install zeromq driver on linux
ldconfig

# Check installed
ldconfig -p | grep zmq

# Expected
############################################################
# libzmq.so.5 (libc6,x86-64) => /usr/local/lib/libzmq.so.5
# libzmq.so (libc6,x86-64) => /usr/local/lib/libzmq.so
############################################################
