#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

### Install softwares ###
echo "Installing softwares..."

## Rust
echo "Installing rust..."
# quiet option doesn't seem to do much see https://github.com/rust-lang/rustup/issues/3350
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -q
echo "Installed rust"

## Xmake
echo "Installing xmake..."
# cannot be quieter until https://github.com/xmake-io/xmake/issues/3714 is fixed
curl -fsSL https://xmake.io/shget.text | bash 1>/dev/null
echo "Installed xmake"

## Additionnal softwares
echo "Installing additional softwares..."

# Install sccache first then the rest to speed up the process
~/.cargo/bin/cargo install -q sccache
echo "Installed sccache"
## Array of cargo packages to install
CARGO_PKGS="
bacon
bat
bob-nvim
bottom
cargo-edit
cargo-leptos
cargo-update
coreutils
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
# shellcheck disable=SC2046,SC2086
RUSTC_WRAPPER=~/.cargo/bin/sccache ~/.cargo/bin/cargo install --locked -q $CARGO_PKGS # cargo doesn't like quotes around `$CARGO_PKGS`
echo "Installed cargo softwares: $CARGO_PKGS"

## Node
~/.cargo/bin/rtx install node

## Nvim
~/.cargo/bin/bob use latest
echo "Installed nvim via bob"

## Brew if on MacOS
[ "$(uname -s)" = 'Darwin' ] && ./scripts/mac_softwares.sh
