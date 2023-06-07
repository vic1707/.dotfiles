#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

## source some helpers functions
# shellcheck source=shell/common/functions.sh
. "$DOTS_DIR/shell/common/functions.sh"

# shellcheck source=scripts/config_files.sh
. "$DOTS_DIR/scripts/config_files.sh"
# shellcheck source=scripts/fonts.sh
. "$DOTS_DIR/scripts/fonts.sh"
# shellcheck source=scripts/shell.sh
. "$DOTS_DIR/scripts/shell.sh"
