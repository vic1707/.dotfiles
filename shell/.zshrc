#!/bin/bash
#^ only affects shellcheck as \. will always use the current shell (zsh in my case)

# Load exports if existent.
[ -f "$HOME/.dotfiles/shell/env.sh" ] && \. "$HOME/.dotfiles/shell/env.sh"
# Load functions if existent.
[ -f "$HOME/.dotfiles/shell/functions.sh" ] && \. "$HOME/.dotfiles/shell/functions.sh"
# Load aliases if existent.
[ -f "$HOME/.dotfiles/shell/aliases.sh" ] && \. "$HOME/.dotfiles/shell/aliases.sh"
# Load keybindings if existent.
[ -f "$HOME/.dotfiles/shell/keybindings.sh" ] && \. "$HOME/.dotfiles/shell/keybindings.sh"

# sourcing all plugins in the "$HOME/.dotfiles/zsh-plugins" directory
for plugin in "$HOME/.dotfiles/zsh-plugins"/*; do
  [ -d "$plugin" ] && \. "$plugin/${plugin##*/}.plugin.zsh"
done

# >>> xmake >>>
test -f "$HOME/.xmake/profile" && \. "$HOME/.xmake/profile" # load xmake profile
# <<< xmake <<<

## Load RTX
eval "$(rtx activate zsh)"

## Load starship
eval "$(starship init zsh)"
