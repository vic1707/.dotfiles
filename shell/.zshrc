#!/bin/zsh

# Load exports if existent.
[ -f "$HOME/.dotfiles/shell/exports.sh" ] && source "$HOME/.dotfiles/shell/exports.sh"
# Load functions if existent.
[ -f "$HOME/.dotfiles/shell/functions.sh" ] && source "$HOME/.dotfiles/shell/functions.sh"
# Load aliases if existent.
[ -f "$HOME/.dotfiles/shell/aliases.sh" ] && source "$HOME/.dotfiles/shell/aliases.sh"

## Load starship
eval "$(starship init zsh)"
