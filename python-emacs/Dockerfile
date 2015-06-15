FROM ubuntu

MAINTAINER Julien Chastang <chastang@ucar.edu>

###
# emacs and python-emacs releated stuff
#
###

RUN apt-get update

RUN apt-get install -y curl emacs git

# Create some directories
RUN mkdir -p  /root/.emacs.d/git
RUN mkdir -p  /root/work

# Clone various repos related to emacs

WORKDIR /root/.emacs.d/git

RUN git clone https://github.com/tkf/emacs-ipython-notebook

RUN git clone https://github.com/ahyatt/emacs-websocket

RUN git clone https://github.com/tkf/emacs-request

RUN git clone -b python https://github.com/julienchastang/dotemacs

WORKDIR /root/work

###
# Install python and ancillary packages
###

RUN apt-get install -y git python

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
  pylint tornado pyzmq || true


###
# Ancillary Python packages that could be useful
###

#RUN pip install <pip packages>

###
# Emacs initialization
###

ADD init.el /root/.emacs.d/init.el

# kludge just to force emacs to run once to grab elpa
RUN emacs --batch -l /root/.emacs.d/init.el || true

RUN emacs -batch --eval '(quote jedi:install-server)' || true

VOLUME /root/work

CMD "emacs"
