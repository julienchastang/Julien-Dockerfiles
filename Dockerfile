ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="julien.c.chastang@gmail.com"

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

####
# Must manually maintain a few packages
####

RUN mkdir -p $HOME/.emacs.d/git

WORKDIR $HOME/.emacs.d/git

RUN git clone https://code.orgmode.org/bzg/org-mode && \
    git clone -b python https://github.com/julienchastang/dotemacs && \
    git clone https://github.com/rlister/org-present && \
    git clone https://github.com/daic-h/emacs-rotate && \
    git clone https://github.com/novoid/title-capitalization.el

RUN mkdir -p $HOME/.emacs.d/wget

WORKDIR $HOME/.emacs.d/wget

RUN mkdir infoplus && wget https://www.emacswiki.org/emacs/download/info%2b.el -O infoplus/info+.el

####
# Make org
####

WORKDIR $HOME/.emacs.d/git/org-mode

RUN make autoloads

WORKDIR $HOME

####
# More emacs python stuff
####

COPY environment.yml $HOME

COPY init.el $HOME/.emacs.d/init.el

RUN conda env update --name root -f $HOME/environment.yml && \
    emacs --batch -l $HOME/.emacs.d/init.el || true && \
    pip install -U $HOME/.emacs.d/elpa/jedi-core* && \
    rm -rf $HOME/.emacs.d/elpa/org-2*

CMD "/bin/bash"





