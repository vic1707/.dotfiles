#!/bin/bash

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
check_command_exists "zsh"
check_command_exists "curl"
check_command_exists "pkg-config"
echo "Ensure that libssl-dev or eq. is installed"
read -p "Press enter to continue"


# way to source or echo if file doesn't exist (usefull for plugins)

ln -fs "$HOME/.dotfiles/shell/.zshrc" "$HOME/.zshrc"
ln -fs "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
mkdir -p "$HOME/.config"
ln -fs "$HOME/.dotfiles/.config/nvim" "$HOME/.config/nvim"
ln -fs "$HOME/.dotfiles/.config/starship.toml" "$HOME/.config/starship.toml"

echo "Minimal config done"

## fonts
cp -r "$HOME/.dotfiles/fonts/"* "$(uname -s | grep -q Darwin && echo "$HOME/Library/Fonts" || echo "$HOME/.local/share/fonts")"
echo "Fonts installed"

## install software
./scripts/softwares.sh
