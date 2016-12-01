#!/bin/bash
#
#  Build a complete release given the following arguments
#
# build_everything.sh <root-version> <rcSetupVersion> <RootCoreReleaseVersion> <CERN-Username>
#
# How to determine the information:
#  1) Log into a lxplus node (or similar)
#  2) setupATLAS
#  3) echo $ATLAS_LOCAL_RCSETUP_PATH
#  4) Pick the rcSetup from that line
#      /cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase/x86_64/rcSetup/00-04-16 => 00-04-16
#  5) mkdir bogus
#  6) cd bogus
#  7) rcSetup Base,4.1.18
#  8) Read the root version off the command line (6.04.16 => v6.04.16)
#
# Ex:
#	build_everything.sh v6-04-16 00-04-16 4.1.18 gwatts
#
# Pre-req:
#    - kinit has been done so that release code can be checked out.

ROOTVersion=$1
RCSetupVersion=$2
RCVersion=$3
User=$4

# Build root
./build_ROOT.sh $ROOTVersion

# Build RootCore and the setup config
source ~/ATLAS/root-source/$ROOTVersion/bin/thisroot.sh
export SVN_USER=gwatts
./build_RootCoreRelease.sh $RCSetupVersion $RCVersion $User