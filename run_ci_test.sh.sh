#!/bin/bash
#
# This bash script powers the CI test for this package. You can copy
# the commands directly from here if you want to see what "passes tests".
# There are some caveats, however!!
#
# 1. The CI environment is setup with bash being automatically in root

# This first line makes sure that everything has been correctly setup
# in the envrionment. Normally you would have to prefex this line
# by "sudo".
./setup_sudo.sh
