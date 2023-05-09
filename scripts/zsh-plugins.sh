#!/bin/bash

zsh_plugins=(
  "zsh-users/zsh-syntax-highlighting"
  "zsh-users/zsh-autosuggestions"
)

for plugin in "${zsh_plugins[@]}"; do
  if [ ! -d "$HOME/.dotfiles/zsh-plugins/$plugin" ]; then
    git clone "https://github.com/$plugin" "$HOME/.dotfiles/zsh-plugins/${plugin#*/}" > /dev/null 2>&1
  fi
done
