#/bin/bash
#
# Download and compile root.
# This assumes everything is ready.
# This assumes we are in the local directory where all root installations
# can be built.
#

tag=v6-04-16

# Get git down here and clone it.
if [ ! -d root-source ]; then
  git clone http://root.cern.ch/git/root.git root-source
  cd root-source
  git checkout -b $tag $tag
  cd ..
fi
loc=$PWD/root-source

# Configure and build with cmake.
# Instructions found here: https://root.cern.ch/building-root

mkdir $tag
cd $tag
cmake $loc
cmake --build . -- -j2

