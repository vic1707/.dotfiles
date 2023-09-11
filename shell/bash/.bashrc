#!/bin/bash

# REQUIRED ENVIRONMENT VARIABLE
DOTS_DIR="$HOME/.dotfiles"
export DOTS_DIR

################################
#         source config        #
################################

# shellcheck source=shell/common/__index.sh
. "$DOTS_DIR/shell/common/__index.sh"

# doesn't seems to be automatically loaded on macos
# shellcheck source=shell/bash/.bash_profile
. "$HOME/.bash_profile"

# shellcheck source=shell/bash/keybindings.bash
. "$DOTS_DIR/shell/bash/keybindings.bash"

# shellcheck source=shell/bash/completions.bash
. "$DOTS_DIR/shell/bash/completions.bash"

# shellcheck source=shell/bash/functions.bash
. "$DOTS_DIR/shell/bash/functions.bash"

## Load starship prompt
## idealy needs to be at the end of the file
eval "$(starship init bash)"
