#!/bin/sh

################################
# This script need to be POSIX #
################################

# shellcheck source=shell/common/aliases.sh
. "$DOTS_DIR/shell/common/aliases.sh"
# shellcheck source=shell/common/env.sh
. "$DOTS_DIR/shell/common/env.sh"
# shellcheck source=shell/common/functions.sh
. "$DOTS_DIR/shell/common/functions.sh"
# shellcheck source=shell/common/PATH.sh
. "$DOTS_DIR/shell/common/PATH.sh"
# shellcheck source=shell/common/soft.sh
. "$DOTS_DIR/shell/common/soft.sh"

# loading platform specific scripts
UNAME="$(uname -s)"
if [ "$UNAME" = "Linux" ]; then
  # shellcheck source=shell/common/_LINUX.sh
  . "$DOTS_DIR/shell/common/_LINUX.sh"
elif [ "$UNAME" = "Darwin" ]; then
  # shellcheck source=shell/common/_MAC_OS.sh
  . "$DOTS_DIR/shell/common/_MAC_OS.sh"
fi
