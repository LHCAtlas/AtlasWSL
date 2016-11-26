# AtlasWSL
Code to setup and test Window's 10 WSL for ATLAS RootCore analysis Software

Goal for Version 1:
 - Starting from a fresh install Win10 WSL 
 - Compile the DiVertAnalysis RootCore skimming program
 - Run it on a downloaded file
 
Goal for version 2:
 - Additionally run rucio
 
# Instructions

## Building RootCore for later use

 1. Check out this package somewhere on windows
 2. In WSL cd into this packages main directory.
 3. sudo $PWD/setup_sudo.sh
 4. log in so svn and the like works properly: kinit -f xxx@CERN.CH
 5. Determine what version of root you need to use. Log into CERN (or similar), and do a "rcSetup Base, xxx" to get the root version number
 6. Download and build the correct root version in ~/ATLAS (modify the compile_ROOT.sh source file). This step can take a while. It is necessary to make sure ROOT is built with the same compiler as RootCore: ./compile_ROOT.sh
 7. Edit the build_RootCore.sh file to set it to build the proper release and use the proper version of rcSetup (again, look in LXPLUS to see what you want).
 8. Run the RootCore build (execute straight from the line, no "." or source). If this is your first svn usage, you will have to make sure your CERN username is properly set in answer to the svn prompt: /mnt/c/Users/gordo/Documents/Code/AtlasWSL/build_RootCore.sh
 9. Copy the file 
 
## Setup for regular use

The above steps have to be run once. Once everything is built,
each time you start a new shell you must run the following commands:

    source ~/ATLAS/root-source/v06-04-16/bin/thisroot.sh
	source ~/ATLAS/setup_RootCore.sh
	
Then, in a directory where you want to do "work":

    rcSetLocal Base,2.3.53
	
And you should be ready to go. Don't forget to do kinit or your rc checkout_pkg commands will all fail!

# Caveats

   - I have noticed one very annoying bug in WSL. If you do 
     "mv dir/ newdir/" you will cause a hang inside a driver. Since it is above
	 driver hang, you have to reboot to get bash back.
	 Remove the trailing "/" and everything will work. This bug was fixed
	 just after the Win10 Annaversary update was released (e.g. fixed if you
	 are running on the insiders or a later build). But it looks like one must
	 wait until the next release of Win10 for this to get released to everyone.
