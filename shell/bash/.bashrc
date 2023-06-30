#!/bin/bash

# REQUIRED ENVIRONMENT VARIABLE
DOTS_DIR="$HOME/.dotfiles"
export DOTS_DIR

################################
#         source config        #
################################

# shellcheck source=shell/common/__index.sh
. "$DOTS_DIR/shell/common/__index.sh"

# shellcheck source=shell/bash/keybindings.bash
. "$DOTS_DIR/shell/bash/keybindings.bash"

# shellcheck source=shell/bash/completions.bash
. "$DOTS_DIR/shell/bash/completions.bash"