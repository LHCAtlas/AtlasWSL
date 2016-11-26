#
# Config the environment to run properly
#

# Location where you will stash everything
# TODO: make sure to set this stuff in one place - as we are going to
# want to keep it common.
anaLoc=~/ATLAS
rcTag=rcSetup-00-04-16


rcSetupLocal() {
    export rcSetupSite=$anaLoc/releases
    export PATHRESOLVER_ALLOWHTTPDOWNLOAD=1
    source ~/ATLAS/rcSetup/$rcTag/rcSetup.sh $*
}
