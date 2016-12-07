#!/bin/bash
# Bash code that must be run as sudo in order to make sure that the
# environment is setup as expected.
#

# Looks like somethings have to be done clean, no matter what. If this is put below
# then it fails to install.
apt-get install -y git

# If we are on an older versino of Ubuntu, to get gcc-4.9 we will need to add a repo
u_version=`lsb_release -c -s`
if [ "trusty" == $u_version ]
then
  add-apt-repository -y ppa:ubuntu-toolchain-r/test
fi

# Make sure all our sources for repos are up to date
apt-get update

# Fetch down the default krb5 conf file. If it is already there,
# then don't touch (presumably the user has already done something to it, order
# a system install?)
scriptDir=`dirname $0`
if [ "$scriptDir" == "." ]
then
  scriptDir=$PWD
fi
if [ ! -f /etc/krb5.conf ]
then
  cp $scriptDir/krb5.conf /etc
fi
apt-get install -y krb5-user

# Compilers
apt-get install -y build-essential
apt-get install -y checkinstall
apt-get install -y gcc-4.9
apt-get install -y g++-4.9

# ROOT packages needed for building

apt-get install -y dpkg-dev
apt-get install -y make
apt-get install -y g++
apt-get install -y gcc
apt-get install -y binutils
apt-get install -y libx11-dev
apt-get install -y libxpm-dev
apt-get install -y libxft-dev
apt-get install -y libxext-dev
apt-get install -y cmake

apt-get install -y python
apt-get install -y libssl-dev
apt-get install -y libpcre3-dev
apt-get install -y xlibmesa-glu-dev
apt-get install -y libglew1.5-dev
apt-get install -y libftgl-dev
apt-get install -y libmysqlclient-dev
apt-get install -y libfftw3-dev
apt-get install -y cfitsio-dev
apt-get install -y graphviz-dev
apt-get install -y libavahi-compat-libdnssd-dev
apt-get install -y libldap2-dev
apt-get install -y python-dev
apt-get install -y libxml2-dev
apt-get install -y libkrb5-dev
apt-get install -y libgsl0-dev libqt4-dev

# CERN Access. Unfortunately, this will make a demand of the user
apt-get install -y subversion
apt-get install -y krb5-config
apt-get install -y krb5-user

# Required for RootCore builds.
apt-get install -y libboost1.55-all-dev
apt-get install -y doxygen

# Clean update
apt-get -f install -y

# Setup gcc alternatives, and configure gcc 4.9
if [ -e /usr/bin/gcc-4.9 ]
then
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9
fi
if [ -e /usr/bin/gcc-4.8 ]
then
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 40 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8
fi
if [ -e /usr/bin/gcc-5 ]
then
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 50 --slave /usr/bin/g++ g++ /usr/bin/g++-5
fi
update-alternatives --auto gcc
