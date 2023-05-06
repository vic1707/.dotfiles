#!/bin/bash

### Install softwares ###
echo "Installing softwares..."

## Rust
echo "Installing rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
echo "Installed rust"

## Xmake
echo "Installing xmake..."
curl -fsSL https://xmake.io/shget.text | bash
echo "Installed xmake"

## Additionnal softwares
echo "Installing additional softwares..."

# Install sccache first then the rest to speed up the process
~/.cargo/bin/cargo install sccache
echo "Installed sccache"
## Array of cargo packages to install
declare -a packages=(
  "bacon"
  "bat"
  "bob-nvim"
  "cargo-edit"
  "cargo-update"
  "coreutils"
  "exa"
  "flamegraph"
  "gitui"
  "nu"
  "ripgrep"
  "rtx-cli"
  "starship"
)
RUSTC_WRAPPER=~/.cargo/bin/sccache ~/.cargo/bin/cargo install "${packages[@]}"
echo "Installed" "${packages[@]}"

## Node
~/.cargo/bin/rtx install node

## Nvim
~/.cargo/bin/bob use latest
echo "Installed nvim via bob"

## Brew if on MacOS
[[ "$OSTYPE" == "darwin"* ]] && ./scripts/mac_softwares.sh
