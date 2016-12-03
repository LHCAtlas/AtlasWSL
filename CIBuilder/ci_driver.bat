REM Overall driver for continuous integration. It will blow away everything.
REM WSL should already be enabled
REM should be run from the root directory

REM Build the support apps, and add them to the path
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\vsvars32.bat"
MSBuild.exe /p:Configuration=Release /p:Platform="Any CPU" "CIBuilder\wsl-bash-wrapper\wsl-bash-wrapper.sln"
set "PATH=%PATH%;%cd%\CIBuilder\wsl-bash-wrapper\wsl-bash-wrapper\bin\Release"

REM Remove and install the linux subsystem to make sure we are starting
REM with a clean known state.
REM This will install with root as the default username.

REM lxrun /uninstall /full /y
REM lxrun /install /y

REM Next, configure the machine as sudo in order to have what is needed
REM to run software (e.g. have gcc 4.9, etc.).
BashWrapper -c "cat setup_sudo.sh"
BashWrapper -c setup_sudo.sh

REM Create a user account
lxrun /setdefaultuser joeuser /y

REM Do the kinit. We need to be on a machine that has
REM the appropriate generic credential for this to work.

REM Make sure the host key for the svn machine is in our known_hosts file
REM so the next step doesn't get hung up. The svn machine will just
REM close the connection, but ssh will properly update the known_hosts file.
BashWrapper -c set
BashWrapper -c ssh gwatts@svn.cern.ch -o StrictHostKeyChecking=no

REM Download and build everything we need
BashWrapper -c build_everything.sh v6-04-16 00-04-16 2.4.18 gwatts
