REM Overall driver for continuous integration. It will blow away everything.
REM WSL should already be enabled
REM should be run from the root directory

REM Remove and install the linux subsystem to make sure we are starting
REM with a clean known state.
REM This will install with root as the default username.

lxrun /uninstall /full /y
lxrun /install /y

REM Next, configure the machine as sudo in order to have what is needed
REM to run software (e.g. have gcc 4.9, etc.).
bash setup_sudo.sh

REM Create a user account
lxrun /setdefaultuser /y joeuser

REM Do the kinit. We need to be on a machine that has
REM the appropriate generic credential for this to work.

REM Download and build everything we need
bash build_everything.sh v6-04-16 00-04-16 4.1.18 gwatts
