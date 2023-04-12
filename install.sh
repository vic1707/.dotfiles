#!/bin/bash

ln -fs "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
ln -fs "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -fs "$HOME/.dotfiles/.config/nvim" "$HOME/.config/nvim"

echo "Minimal config done"

## fonts
cp -r "$HOME/.dotfiles/fonts/"* "$(uname -s | grep -q Darwin && echo "$HOME/Library/Fonts" || echo "$HOME/.local/share/fonts")"
echo "Fonts installed"

## install software
./softwares.sh
