#!/bin/zsh

# Load exports if existent.
[ -f "$HOME/.dotfiles/shell/env.sh" ] && source "$HOME/.dotfiles/shell/env.sh"
# Load functions if existent.
[ -f "$HOME/.dotfiles/shell/functions.sh" ] && source "$HOME/.dotfiles/shell/functions.sh"
# Load aliases if existent.
[ -f "$HOME/.dotfiles/shell/aliases.sh" ] && source "$HOME/.dotfiles/shell/aliases.sh"

# sourcing all plugins in the "$HOME/.dotfiles/zsh-plugins" directory
for plugin in $HOME/.dotfiles/zsh-plugins/*; do
  [ -d "$plugin" ] && source "$plugin/${plugin##*/}.plugin.zsh"
done

## Load starship
eval "$(starship init zsh)"
