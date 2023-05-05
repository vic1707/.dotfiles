#!/bin/bash

ln -fs "$HOME/.dotfiles/shell/.zshrc" "$HOME/.zshrc"
ln -fs "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
mkdir -p "$HOME/.config"
ln -fs "$HOME/.dotfiles/.config/nvim" "$HOME/.config/nvim"
ln -fs "$HOME/.dotfiles/.config/starship.toml" "$HOME/.config/starship.toml"

echo "Minimal config done"

## fonts
cp -r "$HOME/.dotfiles/fonts/"* "$([[ "$OSTYPE" == "darwin"* ]] && echo "$HOME/Library/Fonts" || echo "$HOME/.local/share/fonts")"
echo "Fonts installed"

## install zsh plugins
./scripts/zsh-plugins.sh
## install software
./scripts/softwares.sh
