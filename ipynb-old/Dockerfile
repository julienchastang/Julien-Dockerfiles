FROM python-base

# Create an example environment, but could create others
RUN conda create -n ipynb-old --yes --quiet python=2 numpy matplotlib \
  ipython=0.13.2 ipython-notebook=0.13.2 netcdf4 basemap

# http://stackoverflow.com/questions/24795239/starting-the-ipython-notebook
RUN conda update -n ipynb-old --yes --quiet pyzmq

RUN conda install -n ipynb-old --yes --quiet -c \
  https://conda.binstar.org/jjhelmus pyproj

RUN conda create -n ipynb-old-cartopy --yes python=2 numpy matplotlib \
  ipython=0.13.2 ipython-notebook=0.13.2 netcdf4

RUN conda update -n ipynb-old-cartopy --yes --quiet pyzmq

RUN conda install -n ipynb-old-cartopy --yes --quiet -c \
  https://conda.binstar.org/ioos cartopy

WORKDIR /notebooks

VOLUME /notebooks

EXPOSE 8888

CMD "/bin/bash"

# RUN source activate ipynb-old

# CMD "ipython notebook --pylab=inline --ip=* --no-browser"
