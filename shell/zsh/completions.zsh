#!/bin/zsh

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# RTX
eval "$(rtx activate zsh)"

# Starship
eval "$(starship completions zsh)"
