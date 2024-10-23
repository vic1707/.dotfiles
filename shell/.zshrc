#!/usr/bin/env zsh

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Remove '/' and `-` from the existing WORDCHARS
export WORDCHARS="${WORDCHARS:s/\//}"
export WORDCHARS="${WORDCHARS:s/-/}"

. "$HOME/.dotfiles/shell/__index.sh"
