#!/bin/bash
# Setup svh for general use

user=$1

addit=1
if [ -e ~/.ssh/config ]; then
  used=`grep svn.cern.ch ~/.ssh/config`
  if [ "X$used" != "X" ]; then
    addit=0
  fi
fi

if [ $addit == 1 ]; then
  echo "Host svn.cern.ch" >> ~/.ssh/config
  echo "User $user" >> ~/.ssh/config
  chmod o-w ~/.ssh/config
fi
