FROM ubuntu

MAINTAINER Julien Chastang <chastang@ucar.edu>

###
# emacs and python-emacs releated stuff
#
# wget make and m4 are required for netCDF4-python compilation
###

RUN apt-get update

RUN apt-get install -y curl emacs git wget make m4

# Create some directories
RUN mkdir -p  /root/.emacs.d/git
RUN mkdir -p  /root/work

# Clone various repos

WORKDIR /root/.emacs.d/git

RUN git clone https://github.com/tkf/emacs-ipython-notebook

RUN git clone https://github.com/ahyatt/emacs-websocket

RUN git clone https://github.com/tkf/emacs-request

RUN git clone -b python https://github.com/julienchastang/dotemacs

WORKDIR /root/work

###
# Install scipy related stuff
###

RUN apt-get install -y git python python-scipy python-matplotlib \
  python-pandas python-numpy

###
# pip
###

RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"

RUN python get-pip.py

RUN pip install --upgrade pip

###
# Install pip related packages related to emacs
###

RUN pip install -q ipython jedi rope flake8 epc virtualenv argparse \
  pylint || true

###
# Install netcdf4-python
###

COPY install_netcdf4.sh /tmp/

RUN /bin/bash /tmp/install_netcdf4.sh


###
# Ancillary Python packages that could be useful
###

RUN pip install xray seaborn

###
# Emacs initialization
###

ADD init.el /root/.emacs.d/init.el

# kludge just to force emacs to run once to grab elpa
RUN emacs --batch -l /root/.emacs.d/init.el || true

RUN emacs -batch --eval '(quote jedi:install-server)' || true

VOLUME /root/work

CMD "emacs"
