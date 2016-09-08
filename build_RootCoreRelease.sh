#!/bin/bash
#
# Pull down and build a release ready to go
#
# Prereqs:
#   - kinit so that we have already have access to CERN
#   - ROOTSYS, etc., should already be defined
#   - Current directory is where directories, etc., are to be built
#     containing RootCore tools and, finally, the release.
#

# Config

# Which version of rcSetup shoudl we used?
rcTag=rcSetup-00-04-16

##############
# Get the rcSetup code
rcSetupDir=rcSetup/$rcTag
if [ ! -d $rcSetupDir ]; then
  mkdir -p $rcSetupDir
  svn co svn+ssh://svn.cern.ch/reps/atlasoff/rcSetup/tags/rcSetup-00-04-12 $rcSetupDir
fi

# Load in the rcSetup command.
dir=`dirname $0`
source $dir/setup_RootCore.sh

# Now make 
# Next, setup and checkout a release for building.
rel=2.3.51
mkdir -p $anaLoc/releases
cd $anaLoc/releases
rcSetupLocal -d Base,$rel

# Go to the directory where you checked out the sources:
cd $anaLoc/releases/AnalysisBase/$rel/

# Tell RootCore where it will find Boost:
export BOOSTLIBDIR=/usr/lib
export BOOSTINCDIR=/usr/include
# Set up RootCore:
source RootCore/scripts/setup.sh
# Compile the packages:
rc find_packages
mkdir log
export ROOTCORELOG=$PWD/log
rc compile --continue --log-files
rc strip --remove-debug
