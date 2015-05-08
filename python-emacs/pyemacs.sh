#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Syntax: $(basename $0) <output dir>"
    exit 1
fi

if [ ! -d $1 ]; then
    mkdir -p $1
fi

echo For X11 emacs, will need to run socat
echo
read -p "Press [Enter] key to start pyemacs..."

docker run -v $1:/root/work -p 8889:8889 -e DISPLAY=192.168.59.3:0  --rm -it python-emacs
