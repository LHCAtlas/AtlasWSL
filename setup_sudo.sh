#!/bin/bash
# Bash code that must be run as sudo in order to make sure that the
# environment is setup as expected.
#

apt-get update

# Compilers
apt-get install -y build-essential checkinstall gcc-4.9