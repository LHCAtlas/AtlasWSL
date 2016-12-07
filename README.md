# AtlasWSL
Code to setup and test Window's 10 WSL for ATLAS RootCore analysis Software

Goal for Version 1:
 - Starting from a fresh install Win10 WSL 
 - Compile the DiVertAnalysis RootCore skimming program
 - Run it on a downloaded file
 
Goal for version 2:
 - Additionally run rucio
 
# Instructions

No matter what you do, you will have to configure your Ubuntu - compilers, etc. Once that is done you can
either download a pre-built release or build it from scratch yourself. The download, if the configuration you want
is availible, is much faster.

## Setup your machine

You need to do this only one time. This assumes a fresh WSL installation - but you can start from anything you want.
You should make sure to inspect the script that is run at root level before you execute it!

1. Turn on the WSL feature in Windows
    1. From the start menu type "Turn Windows Features on or off"
	1. Scroll down and find the "Windows Subsystem for Linux (Beta)"
	1. Select it and click ok and wait for it to be installed.
1. Create the Ubuntu distribution
	1. From a command line prompt (cmd or powershell) - takes a few minutes:
	lxrun /install
	1. Create a username for yourself. I STRONGLY recommend using the same username as you do at CERN. This makes kerberos and svn much more pleasent!!
1. Fetch the AtlasWSL project and run the sudo script.
    bash
	cd ~
	sudo apt-get install git
	git clone https://github.com/LHCAtlas/AtlasWSL.git
	sudo bash -c "source /home/gwatts/AtlasWSL/setup_sudo.sh"
	1. When the request for the kerberos domain comes up, enter "CERN.CH"
1. Make sure kinit works by doing
    kinit -f username@CERN.CH
1. If your username is not your CERN username, then you will need to create a new SVN username
    source AtlasWSL/configure_ssh_for_cern_svn.sh <username>

Your system should now be configured to work with RootCore.

## Installing a pre-built release

Do not mix Ubuntu versions, at lesat not major versions, or it will not be pleasent. To find out your Ubuntu verison:

	lsb_release -a
	
Look for the release tag line. The release that pre-built were built on is encoded in the filename or the tar archive.

1. Download the prebuilt release and place it in your home directory (cd ~)
2. Unpack it

    cd ~
	tar -xzf AnalysisBase-02-04-18-ubuntu-14.05.tar.gz	

## Building RootCore from scratch

This is incomplete and under construction!!

1. You have to determine the rcSetup version, ROOT version, and, of course, release you want to built. To do this, log into lxplus, and do a rcSetup Base,xxx as you would normally.
1. Look at the environment variable ROOTSYS to determine the root version.
1. Look at the environment variable PATH to determine the rcSetup version.
1. Do the kinit, I'd also suggest making sure that you can access the svn machine without getting prompted
	ssh username@svn.cern.ch
1. Run the build script. This takes almost 4 hours on a 4 core machine running in a VM:
	./build_everything.sh v6-04-16 00-04-16 2.4.18 <username>
Where the first argument is the ROOT version number, the second the rcSetup version number, the third is the AnalysisBase RootCore release number, and username is your CERN username.
 
These steps are followed by the continuous integration server. To double check that docs are correct, look at the .bat file in the CIBuilder directory.
 
## Setup for regular use

The above steps have to be run once. Once everything is built,
each time you start a new shell you must run the following commands:

    source ~/ATLAS/root-source/v06-04-16/bin/thisroot.sh
	source ~/ATLAS/releases/setup_RootCore.sh
	
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

# Other options

It may be possible to get CentOS or SL6 running inside WSL. Turns out the filesystem is based on docker images,
and there is some code that will do the setch. See [WSL Distribution Switcher](https://github.com/RoliSoft/WSL-Distribution-Switcher) on github.
