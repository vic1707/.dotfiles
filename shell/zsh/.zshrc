#!/bin/zsh

# REQUIRED ENVIRONMENT VARIABLE
DOTS_DIR="$HOME/.dotfiles"
export DOTS_DIR
# keep it up to date with `scripts/__consts.sh` line 14
BASE_ZSH_PLUGINS_DIR="$DOTS_DIR/shell/zsh/.zsh-plugins"
export BASE_ZSH_PLUGINS_DIR

################################
#         source config        #
################################

# shellcheck source=shell/common/__index.sh
. "$DOTS_DIR/shell/common/__index.sh"

for plugin in "$BASE_ZSH_PLUGINS_DIR"/*; do
  # shellcheck disable=SC1090 # is completly dynamic
  test -d "$plugin" && \. "$plugin/${plugin##*/}.plugin.zsh"
done

# shellcheck source=shell/zsh/keybindings.zsh
. "$DOTS_DIR/shell/zsh/keybindings.zsh"

# shellcheck source=shell/zsh/completions.zsh
. "$DOTS_DIR/shell/zsh/completions.zsh"

# shellcheck source=shell/zsh/functions.zsh
. "$DOTS_DIR/shell/zsh/functions.zsh"

################################
#         ZSH settings         #
################################

# History
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
setopt appendhistory

## Load starship prompt
## idealy needs to be at the end of the file
eval "$(starship init zsh)"
