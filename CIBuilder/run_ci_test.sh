#!/bin/bash
#
# This bash script powers the CI test for this package. You can copy
# the commands directly from here if you want to see what "passes tests".
# There are some caveats, however!!
#
# 1. The CI environment is setup with bash being automatically in root

cd ~

# Figure out where the script is located. If you sourced this,
# this won't work. Please don't source this.
v=`dirname $0`
scriptDir=$v/..

# This first line makes sure that everything has been correctly setup
# in the envrionment. Normally you would have to prefex this line
# by "sudo".
. $scriptDir/setup_sudo.sh

# Next, do the kinit
#kinit -f gwatts@CERN.CH << EOF
#atlas2020!
#EOF

# Next build ROOT
#. $scriptDir/compile_ROOT.sh
