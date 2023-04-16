#!/bin/bash
source ./shell/functions.sh

### Check if commands exists ###
__command_exists_f "zsh"
__command_exists_f "curl"
__command_exists_f "pkg-config"
echo "Ensure that libssl-dev or eq. is installed"
read -pr "Press enter to continue"


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

## install zsh plugins
./scripts/zsh-plugins.sh
## install software
./scripts/softwares.sh
