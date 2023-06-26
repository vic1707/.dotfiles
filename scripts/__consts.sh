#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

# shellcheck source=scripts/__pkgs.sh
. "$DOTS_DIR/scripts/__pkgs.sh"

## 3_shell.sh ##
AVAILABLE_SHELLS="zsh bash"
ZSH_PLUGINS="
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-autosuggestions
"
# keep this up to date with `.zshrc` line 5
BASE_ZSH_PLUGINS_DIR="$DOTS_DIR/shell/zsh/.zsh-plugins"

# Export variables
export AVAILABLE_SHELLS
export ZSH_PLUGINS
export BASE_ZSH_PLUGINS_DIR
