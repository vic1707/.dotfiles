#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################
SUPPORTED_PM="brew apt apt-get"
export SUPPORTED_PM

# shellcheck source=scripts/package-managers/apt.sh
. "$DOTS_DIR/scripts/package-managers/apt.sh"

# shellcheck source=scripts/package-managers/brew.sh
. "$DOTS_DIR/scripts/package-managers/brew.sh"
