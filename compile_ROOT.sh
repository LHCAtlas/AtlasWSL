#/bin/bash
#
# Download and compile root.
# This assumes everything is ready.
# This assumes we are in the local directory where all root installations
# can be built.
#

tag=v6-04-16
# Get git down here and clone it.
if [ ! -d ~/ATLAS/root-source ]; then
  git clone http://root.cern.ch/git/root.git ~/ATLAS/root-source/root
  cd ~/ATLAS/root-source
  git checkout -b $tag $tag
fi
loc=~/ATLAS/root-source

# Configure and build with cmake.
# Instructions found here: https://root.cern.ch/building-root

mkdir $tag
cd $tag
cmake $loc
cmake --build . -- -j2

