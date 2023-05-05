#!/bin/bash

#########################
# Linux requirements    #
# - curl                #
# - libssl-dev (or eq.) #
# - pkg-config          #
#########################

### Utilities ###
function get_latest_github_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | \
    grep '"tag_name":' | \
    head -1 | \
    sed -E 's/.*"([^"]+)".*/\1/'
}

### Install softwares ###
echo "Installing softwares..."

## NVM
echo "Installing nvm..."
NVM_VERSION=$(get_latest_github_release "nvm-sh/nvm")
curl --silent -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash 
echo "Installed nvm"

## Node
echo "Installing node..."
\. ~/.nvm/nvm.sh && nvm install node 
echo "Installed node"

## Rust
echo "Installing rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 
echo "Installed rust"

## Xmake
echo "Installing xmake..."
curl -fsSL https://xmake.io/shget.text | bash 
echo "Installed xmake"

## Starship
echo "Installing starship..."
curl -fsSL https://starship.rs/install.sh | sh -s -- -y 
echo "Installed starship"

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
)
RUSTC_WRAPPER=~/.cargo/bin/sccache ~/.cargo/bin/cargo install "${packages[@]}" 
echo "Installed" "${packages[@]}"

## Nvim
~/.cargo/bin/bob use latest 
echo "Installed nvim via bob"

## Brew if on MacOS
[[ "$OSTYPE" == "darwin"* ]] && ./scripts/mac_softwares.sh
