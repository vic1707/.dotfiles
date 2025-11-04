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

export ZSH_COMPLETIONS_DIR="$HOME/.zsh-complete"
mkdir -p "$ZSH_COMPLETIONS_DIR"
fpath+=($ZSH_COMPLETIONS_DIR)

. "$HOME/.dotfiles/shell/__index.sh"
