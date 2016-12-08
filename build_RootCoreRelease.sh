#!/bin/bash
#
# Pull down and build a release ready to go
#
# Prereqs:
#   - kinit so that we have already have access to CERN
#   - ROOTSYS, etc., should already be defined
#
#   - This will build everything in ~/ATLAS and below.
#
# build_RootCoreRelease <rCSetupVersion> <RootCoreVersion> <cern-username>
#
# Ex:
#   build_RootCoreRelease.sh 00-04-16 2.4.18 gwatts
#
# These build instructions were copied from:
#	https://twiki.cern.ch/twiki/bin/view/AtlasComputing/SoftwareTutorialxAODEDM#Building_installing_Analysis_AN5
#

# Config

# Which version of rcSetup shoudl we used?
rcTag=rcSetup-$1

# Which release of RootCore AnalysisBase are we goign to build?
rel=$2

# The user which we will configure everything to use
user=$3

### Where are we, since we will move our PWD around a bit
dir=`dirname $0`
if [ "$dir" == "." ]; then
  dir=$PWD
fi

# Make sure svn user is setup correctly.
$dir/configure_ssh_for_cern_svn.sh $user

##############
# Get the rcSetup code
cd ~/ATLAS
rcSetupDir=rcSetup/$rcTag
if [ ! -d $rcSetupDir ]; then
  mkdir -p $rcSetupDir
  svn co svn+ssh://svn.cern.ch/reps/atlasoff/rcSetup/tags/rcSetup-00-04-12 $rcSetupDir
fi

# Load in the rcSetup command.
mkdir -p ~/ATLAS/releases
if [ ! -e ~/ATLAS/releases/setup_RootCore.sh ]; then
  cp $dir/setup_RootCore.sh ~/ATLAS/releases
fi
source ~/ATLAS/releases/setup_RootCore.sh

# Now make 
# Next, setup and checkout a release for building.
cd ~/ATLAS/releases
rcSetupLocal -d Base,$rel

# Go to the directory where you checked out the sources:
cd ~/ATLAS/releases/AnalysisBase/$rel/

# Tell RootCore where it will find Boost:
export BOOSTLIBDIR=/usr/lib
export BOOSTINCDIR=/usr/include
# Set up RootCore:
source RootCore/scripts/setup.sh
# Fix up TrigDecisionTool. For a number of the relases it was missing a dependency that was causing a failure
sed -i "s/PACKAGE_PRELOAD  = $/PACKAGE_PRELOAD  = PyROOT/" TrigDecisionTool/cmt/Makefile.RootCore
# Compile the packages:
rc find_packages
# On advice from Attila, clean everything leftover (potentially) from rcSetup
rc clean
# Setup externals, which is missing from the rcSetup
source RootCore/scripts/setup_external.sh
# Now, do the build
mkdir log
rc compile --continue 
rc strip --remove-debug
