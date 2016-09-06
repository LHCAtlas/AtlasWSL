#/bin/bash
#
# Download and compile root.
# This assumes everything is ready.
# This assumes we are in the local directory where all root installations
# can be built.
#

tag=v6-04-16

# Get git down here and clone it.
git clone http://root.cern.ch/git/root.git $tag
cd $tag
git checkout -b $tag $tag


