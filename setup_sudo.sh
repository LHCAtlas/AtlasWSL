#!/bin/bash
# Bash code that must be run as sudo in order to make sure that the
# environment is setup as expected.
#

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
apt-get install -y build-essential checkinstall gcc-4.9 g++-4.9

# ROOT packages needed for building

apt-get install -y git dpkg-dev make g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev cmake

apt-get install -y libssl-dev libpcre3-dev xlibmesa-glu-dev libglew1.5-dev libftgl-dev libmysqlclient-dev libfftw3-dev cfitsio-dev \
graphviz-dev libavahi-compat-libdnssd-dev libldap2-dev python python-dev libxml2-dev libkrb5-dev libgsl0-dev libqt4-dev

# CERN Access. Unfortunately, this will make a demand of the user
apt-get install -y subversion krb5-config krb5-user

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
