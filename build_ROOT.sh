#/bin/bash
#
# Download and compile root.
# This assumes everything is ready.
# This assumes we are in the local directory where all root installations
# can be built.
#

tag=$1
# Get git down here and clone it.
if [ ! -d ~/ATLAS/root-source ]; then
  git clone http://root.cern.ch/git/root.git ~/ATLAS/root-source/root
fi
cd ~/ATLAS/root-source/root

# Has the branch been checked out?
git checkout -B $tag $tag
loc=~/ATLAS/root-source/$tag

# Configure and build with cmake.
# Instructions found here: https://root.cern.ch/building-root

mkdir -p $loc
cd $loc
cmake ~/ATLAS/root-source/root
cmake --build . -- -j2

