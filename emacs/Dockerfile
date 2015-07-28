FROM unidata/python

MAINTAINER Julien Chastang <chastang@ucar.edu>

USER root

###
# Usual maintenance
###

RUN apt-get update

###
# This is a total hack to prevent later installation steps to ask me about
# postfix install. This docker container does not need postfix.
###

run echo "postfix postfix/main_mailer_type string Local only" > /tmp/preseed.txt

run debconf-set-selections /tmp/preseed.txt

run DEBIAN_FRONTEND=noninteractive apt-get install -q -y postfix

###
# Create some directories
###

RUN mkdir -p /home/python/.emacs.d/git

RUN mkdir -p /home/python/work

RUN mkdir -p /home/python/downloads

RUN mkdir -p /home/python/bin

###
# emacs build. default ubuntu version is dreadfully old
###

RUN apt-get install -y tar curl git build-essential openjdk-8-jre

ENV CURL_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt

ADD cacerts /etc/ssl/certs/java/cacerts

RUN apt-get -y build-dep emacs24

WORKDIR /home/python/downloads

RUN curl -SL http://ftp.gnu.org/gnu/emacs/emacs-24.5.tar.gz -o emacs-24.5.tar.gz

RUN tar xzfv emacs-24.5.tar.gz

WORKDIR /home/python/downloads/emacs-24.5

RUN ./configure && make && make install

RUN chown -R python:python /home/python/

###
# Clone various repos
###

USER python

WORKDIR /home/python/.emacs.d/git

RUN rm -rf dotemacs && git clone -b python \
    https://github.com/julienchastang/dotemacs

RUN rm -rf ob-ipython &&  git clone https://github.com/gregsexton/ob-ipython

RUN rm -rf org-mode && git clone http://orgmode.org/cgit.cgi/org-mode.git

WORKDIR /home/python/.emacs.d/git/org-mode

RUN make autoloads

###
# Conda
###

ADD conda-packages.txt /home/python/conda-packages.txt

RUN conda install -n root --file /home/python/conda-packages.txt
 
RUN pip install epc

###
# Clojure
###

WORKDIR /home/python/bin

ENV PATH /home/python/bin:$PATH

RUN curl -SL \
    https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o \
    lein

RUN sh lein

RUN chmod a+x /home/python/bin/lein

ADD profiles.clj /home/python/.lein/profiles.clj

###
# Emacs initialization
###

ADD init.el /home/python/.emacs.d/init.el

# kludge just to force emacs to run once to grab elpa
RUN emacs --batch -l /home/python/.emacs.d/init.el || true

RUN pip install -U /home/python/.emacs.d/elpa/jedi-core*

# Get rid of weird versions of org floating around
RUN rm -rf /home/python/.emacs.d/elpa/org-2*

WORKDIR /home/python/work

VOLUME /home/python/work

CMD "/bin/bash"
