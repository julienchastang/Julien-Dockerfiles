FROM ubuntu

MAINTAINER Julien Chastang <chastang@ucar.edu>

# anaconda works better with bash

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# House keeping
RUN apt-get update

RUN apt-get -y upgrade

# Install some Linux packages
RUN apt-get install -y curl

# Create some directories
RUN mkdir -p /root/downloads 

RUN cd /root/downloads && curl -SL \
  http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -o \
  Miniconda-latest-Linux-x86_64.sh

RUN /bin/bash /root/downloads/Miniconda-latest-Linux-x86_64.sh -b -p \
  /root/anaconda/

ENV PATH /root/anaconda/bin:$PATH

RUN conda update --yes --quiet conda

RUN conda config --add channels http://conda.binstar.org/unidata

CMD "/bin/bash"
