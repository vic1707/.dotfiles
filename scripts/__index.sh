#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

## source some helpers functions
# shellcheck source=shell/common/functions.sh
. "$DOTS_DIR/shell/common/functions.sh"
# shellcheck source=scripts/__consts.sh
. "$DOTS_DIR/scripts/__consts.sh"

# shellcheck source=scripts/0_requirements.sh
. "$DOTS_DIR/scripts/0_requirements.sh"
# shellcheck source=scripts/1_config_files.sh
. "$DOTS_DIR/scripts/1_config_files.sh"
# shellcheck source=scripts/2_fonts.sh
. "$DOTS_DIR/scripts/2_fonts.sh"
# shellcheck source=scripts/3_shell.sh
. "$DOTS_DIR/scripts/3_shell.sh"
# shellcheck source=scripts/4_softwares.sh
. "$DOTS_DIR/scripts/4_softwares.sh"
