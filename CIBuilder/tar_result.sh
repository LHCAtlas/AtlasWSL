#!/bin/bash
#
#  Save the result as a TAR file.
#
$stub=$1

cd ~
lxrel=`lsb_release --release --short`
tar -czf AnalysisBase-$stub-ubuntu-$lxrel.tar.gz ATLAS"