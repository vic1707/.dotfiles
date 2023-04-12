#!/bin/bash

ln -fs "~/.dotfiles/.zshrc" ~/.zshrc
ln -fs "~/.dotfiles/.gitconfig" ~/.gitconfig
ln -fs "~/.dotfiles/.config/nvim" ~/.config/nvim

echo "Minimal config done"

## fonts
cp -r ~/.dotfiles/fonts/* "$(uname -s | grep -q Darwin && echo "~/Library/Fonts" || echo "~/.local/share/fonts")"
echo "Fonts installed"
