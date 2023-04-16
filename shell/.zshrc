#!/bin/bash
#^ only affects shellcheck as source will always use the current shell (zsh in my case)

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

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> xmake >>>
[[ -s "$HOME/.xmake/profile" ]] && source "$HOME/.xmake/profile" # load xmake profile
# <<< xmake <<<

## Load starship
eval "$(starship init zsh)"
