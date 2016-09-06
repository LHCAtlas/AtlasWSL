#!/bin/bash
# Bash code that must be run as sudo in order to make sure that the
# environment is setup as expected.
#

apt-get update

# Compilers
apt-get install -y build-essential checkinstall gcc-4.9

# ROOT packages needed for building

apt-get install -y git dpkg-dev make g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev cmake

apt-get install -y libssl-dev libpcre3-dev xlibmesa-glu-dev libglew1.5-dev libftgl-dev libmysqlclient-dev libfftw3-dev cfitsio-dev \
graphviz-dev libavahi-compat-libdnssd-dev libldap2-dev python-dev libxml2-dev libkrb5-dev libgsl0-dev libqt4-dev