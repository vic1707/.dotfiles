#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

## 3_shell.sh ##
AVAILABLE_SHELLS="zsh bash"
ZSH_PLUGINS="
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-autosuggestions
"
# keep this up to date with `.zshrc` line 5
BASE_ZSH_PLUGINS_DIR="$DOTS_DIR/shell/zsh/.zsh-plugins"

## 4_softwares.sh ##
CARGO_PKGS="
bacon
bat
bob-nvim
bottom
cargo-edit
cargo-leptos
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
"

# Export variables
export AVAILABLE_SHELLS
export ZSH_PLUGINS
export BASE_ZSH_PLUGINS_DIR
export CARGO_PKGS
