FROM fedora

MAINTAINER Julien Chastang <chastang@ucar.edu>

RUN yum -y install tar git bzip2

RUN mkdir -p ~/downloads

RUN cd ~/downloads && curl -SL http://repo.continuum.io/miniconda/Miniconda-3.8.3-Linux-x86_64.sh -o Miniconda-3.8.3-Linux-x86_64.sh

RUN /bin/bash ~/downloads/Miniconda-3.8.3-Linux-x86_64.sh -b -p ~/anaconda/

ENV PATH ~/anaconda/bin:$PATH 

RUN conda update --yes --quiet conda

RUN conda config --add channels https://conda.binstar.org/rsignell

RUN conda config --add channels https://conda.binstar.org/Unidata

RUN conda create -n unidata --yes python=2 numpy matplotlib cartopy ipython=0.13.2 ipython-notebook=0.13.2 netcdf4 owslib pyudl networkx basemap iris biggus

RUN source activate unidata

RUN mkdir -p /notebooks

WORKDIR /notebooks

VOLUME /notebooks

EXPOSE 8888

COPY run.sh /

CMD ["sh", "/run.sh"]
