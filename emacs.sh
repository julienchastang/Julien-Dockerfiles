#!/bin/bash

usage="$(basename "$0") [-h] [-v, --volume directory] [-ip, --ip ip address] -- 
script to start emacs:\n
    -h  show this help text\n
    -v, --volume A local host dicrectory that will be bound to the 
/home/jovyan/work direcotry. The default is the 'PWD/..'.\n
    -ip, --ip IP address of X11 host. The default is grabbed from 'ip.appspot.com'\n"

# Set some defaults

PWD=`pwd`

VOLUME=${PWD}/..

# IP=$(curl -s ifconfig.co)

IP=$(ifconfig | grep inet | grep broadcast | head -1 | awk '$1=="inet" {print $2}')

while [[ $# > 0 ]]
do
    key="$1"
    case $key in
        -v|--volume)
            VOLUME="$2"
            shift # past argument
            ;;
        -ip|--ip)
            IP="$2"
            shift # past argument
            ;;
        -h|--help)
            echo $usage
            exit
            ;;
    esac
    shift # past argument or value
done

docker run -v ${VOLUME}:/home/jovyan/work -p 8888:8888 -p 8889:8889 -e DISPLAY=${IP}:0 \
      --rm -it emacs-python
