#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

# shellcheck source=scripts/package-managers/__index.sh
. "$DOTS_DIR/scripts/package-managers/__index.sh"

## 3_shell.sh ##
AVAILABLE_SHELLS="zsh bash nu"
ZSH_PLUGINS="
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-autosuggestions
"
# keep this up to date with `.zshrc` line 5
BASE_ZSH_PLUGINS_DIR="$DOTS_DIR/shell/zsh/.zsh-plugins"

CARGO_PKGS="
bacon
bat
bob-nvim
bottom
cargo-edit
cargo-update
coreutils
diskonaut
du-dust
exa
flamegraph
gitui
git-delta
hyperfine
nu
procs
ripgrep
rtx-cli
starship
tokei
"

# Export variables
export AVAILABLE_SHELLS
export BASE_ZSH_PLUGINS_DIR
export CARGO_PKGS
export ZSH_PLUGINS
