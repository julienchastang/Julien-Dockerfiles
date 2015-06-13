FROM python-base

MAINTAINER Julien Chastang <chastang@ucar.edu>

###
# emacs
###

RUN apt-get update

RUN apt-get install -y curl emacs git

# Create some directories

RUN mkdir -p  /root/.emacs.d/git

RUN mkdir -p  /root/work

# Clone various repos

WORKDIR /root/.emacs.d/git

RUN rm -rf emacs-ipython-notebook && git clone \
    https://github.com/tkf/emacs-ipython-notebook

RUN rm -rf emacs-websocket && git clone \
    https://github.com/ahyatt/emacs-websocket

RUN rm -rf emacs-request && git clone https://github.com/tkf/emacs-request

RUN rm -rf dotemacs && git clone -b python-emacs-24.3 \
    https://github.com/julienchastang/dotemacs

RUN rm -rf ob-ipython &&  git clone https://github.com/julienchastang/ob-ipython

WORKDIR /root/work

#Conda

RUN conda env remove -n scipy || true

RUN conda create -n scipy --yes --quiet python=2 numpy matplotlib netcdf4 pandas \
    ipython jedi rope flake8 virtualenv pylint tornado pyzmq pip \
    xray seaborn

RUN conda install -n scipy --yes --quiet -c http://conda.anaconda.org/auto epc

RUN conda install -n scipy --yes --quiet -c https://conda.binstar.org/unidata \
    metpy siphon
 
###
# Emacs initialization
###

ADD init.el /root/.emacs.d/init.el

# kludge just to force emacs to run once to grab elpa
RUN emacs --batch -l /root/.emacs.d/init.el || true

RUN emacs -batch --eval '(quote jedi:install-server)' || true

VOLUME /root/work

CMD "/bin/bash"

# RUN source activate scipy

# CMD "/bin/bash -c 'source activate scipy && emacs'"
