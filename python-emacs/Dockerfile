FROM fedora

MAINTAINER Julien Chastang <chastang@ucar.edu>

ENV WORK_DIR /root/work

###
# emacs and python-emacs releated stuff
###

RUN yum install -y curl emacs git

# Create some directories
RUN mkdir -p  /root/.emacs.d/git $WORK_DIR

# Clone various repos

WORKDIR /root/.emacs.d/git

RUN git clone https://github.com/tkf/emacs-ipython-notebook

RUN git clone https://github.com/ahyatt/emacs-websocket

RUN git clone https://github.com/tkf/emacs-request

RUN git clone -b python https://github.com/julienchastang/dotemacs

###
# Install Python, pip
###

RUN yum install -y git python python-imaging python-matplotlib

RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"

RUN python get-pip.py

RUN pip install --upgrade pip

###
# Install pip related packages related to emacs
###

RUN pip install -q ipython jedi rope flake8 epc virtualenv argparse pylint || true

###
# Ancillary Python packages that could be useful
###

RUN pip install pyhiccup html5print Pillow 

###
# Emacs initialization
###

ADD init.el /root/.emacs.d/init.el

# kludge just to force emacs to run once to grab elpa
RUN emacs --batch -l /root/.emacs.d/init.el || true

RUN emacs -batch --eval '(quote jedi:install-server)' || true

WORKDIR $WORK_DIR

VOLUME $WORK_DIR

CMD "emacs"
