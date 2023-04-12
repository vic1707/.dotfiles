#!/bin/bash

ln -fs "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
ln -fs "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
mkdir -p "$HOME/.config"
ln -fs "$HOME/.dotfiles/.config/nvim" "$HOME/.config/nvim"
ln -fs "$HOME/.dotfiles/.config/starship.toml" "$HOME/.config/starship.toml"

echo "Minimal config done"

## fonts
cp -r "$HOME/.dotfiles/fonts/"* "$(uname -s | grep -q Darwin && echo "$HOME/Library/Fonts" || echo "$HOME/.local/share/fonts")"
echo "Fonts installed"

## install software
./softwares.sh
