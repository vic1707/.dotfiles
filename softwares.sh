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

function check_command_exists() {
  if ! command -v "$1" &> /dev/null; then
    echo "Error: $1 is not installed (command)"
    exit 1
  fi
  if ! type "$1" &> /dev/null; then
    echo "Error: $1 is not installed (type)"
    exit 1
  fi
  if ! hash "$1" &> /dev/null; then
    echo "Error: $1 is not installed (hash)"
    exit 1
  fi
}

### Check if commands exists ###
check_command_exists "curl"
check_command_exists "pkg-config"
echo "Ensure that libssl-dev or eq. is installed"
read -p "Press enter to continue"

### Install softwares ###
echo "Installing softwares..."

## NVM
echo "Installing nvm..."
NVM_VERSION=$(get_latest_github_release "nvm-sh/nvm")
curl --silent -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash > /dev/null 2>&1
echo "Installed nvm"

## Node
echo "Installing node..."
source ~/.nvm/nvm.sh && nvm install node > /dev/null 2>&1
echo "Installed node"

## Rust
echo "Installing rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y > /dev/null 2>&1
echo "Installed rust"

## Xmake
echo "Installing xmake..."
curl -fsSL https://xmake.io/shget.text | bash > /dev/null 2>&1
echo "Installed xmake"

## Starship
echo "Installing starship..."
curl -fsSL https://starship.rs/install.sh | bash > /dev/null 2>&1
echo "Installed starship"

## Additionnal softwares
echo "Installing additional softwares..."

# Install sccache first then the rest to speed up the process
~/.cargo/bin/cargo install sccache > /dev/null 2>&1
echo "Installed sccache"
## Array of cargo packages to install
declare -a packages=(
  "bacon"
  "bat"
  "bob-nvim"
  "coreutils"
  "exa"
  "gitui"
  "nu"
  "ripgrep"
)
RUSTC_WRAPPER=sccache ~/.cargo/bin/cargo install "${packages[@]}" > /dev/null 2>&1
echo "Installed" "${packages[@]}"

## Nvim
~/.cargo/bin/bob use latest > /dev/null 2>&1
echo "Installed nvim via bob"

unset get_latest_github_release NVM_VERSION packages # Unset functions and variables
