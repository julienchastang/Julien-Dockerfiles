#!/bin/bash

# Script to install hdf5 and netCDF4 libraries on a Linux Ubuntu system
# After: https://code.google.com/p/netcdf4-python/wiki/UbuntuInstall
# And http://unidata.github.io/netcdf4-python/ 

# You can check for newer version of the programs on 
# ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4/
# and other sources

# Install zlib
v=1.2.8  
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4/zlib-${v}.tar.gz
tar -xf zlib-${v}.tar.gz && cd zlib-${v}
./configure --prefix=/usr/local
#sudo make check install
sudo make install
cd ..

# Install HDF5
v=1.8.13
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4/hdf5-${v}.tar.gz
tar -xf hdf5-${v}.tar.gz && cd hdf5-${v}
HDF5_DIR="/usr/local/hdf5-$v"
./configure --enable-shared --enable-hl --prefix=$HDF5_DIR
make -j 2 # 2 for number of procs to be used
sudo make install
cd ..

# Install Netcdf
v=4.3.3.1
wget http://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-${v}.tar.gz
tar -xf netcdf-${v}.tar.gz && cd netcdf-${v}
NETCDF4_DIR="/usr/local/"
CPPFLAGS=-I$HDF5_DIR/include LDFLAGS=-L$HDF5_DIR/lib ./configure --enable-netcdf-4 --enable-shared --enable-dap --prefix=$NETCDF4_DIR
# make check
make 
sudo make install
cd ..

# install python's netCDF4
sudo -E pip install netCDF4 --upgrade
