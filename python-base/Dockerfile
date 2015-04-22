FROM ubuntu

MAINTAINER Julien Chastang <chastang@ucar.edu>

# House keeping
RUN apt-get update

RUN apt-get -y upgrade

# Install some Linux packages
RUN apt-get install -y curl

# Create some directories
RUN mkdir -p /root/downloads 

RUN cd /root/downloads && curl -SL http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -o Miniconda-latest-Linux-x86_64.sh

RUN /bin/bash /root/downloads/Miniconda-latest-Linux-x86_64.sh -b -p /root/anaconda/

ENV PATH /root/anaconda/bin:$PATH

RUN conda update --yes --quiet conda

# Create an example environment, but could create others
RUN conda create -n oldschool --yes python=2 numpy matplotlib ipython=0.13.2 ipython-notebook=0.13.2 netcdf4 basemap

# http://stackoverflow.com/questions/24795239/starting-the-ipython-notebook
RUN conda update -n oldschool --yes --quiet pyzmq

RUN conda install -n oldschool -c https://conda.binstar.org/jjhelmus pyproj

WORKDIR /work

VOLUME /work

EXPOSE 8888

# source activate oldschool
# ipython notebook --pylab=inline --ip=* --no-browser
