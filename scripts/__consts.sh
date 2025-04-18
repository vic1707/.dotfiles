#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

# shellcheck source=scripts/package-managers/__index.sh
. "$DOTS_DIR/scripts/package-managers/__index.sh"

## 3_shell.sh ##
AVAILABLE_SHELLS="zsh bash"
ZSH_PLUGINS="
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-completions
zsh-users/zsh-autosuggestions
"
# keep this up to date with `shell/__index.sh` line 6
BASE_ZSH_PLUGINS_DIR="$DOTS_DIR/shell/.zsh-plugins"

CARGO_PKGS="
cargo-edit
cargo-expand
cargo-generate
cargo-leptos
cargo-license
cargo-msrv
cargo-nextest
cargo-semver-checks
cargo-tarpaulin
cargo-update
cargo-wizard
cargo-zigbuild
coreutils
mise
"
# pi zero dev deps: flip-link probe-rs-tools

# Export variables
export AVAILABLE_SHELLS
export BASE_ZSH_PLUGINS_DIR
export CARGO_PKGS
export ZSH_PLUGINS
