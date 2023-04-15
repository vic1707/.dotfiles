#!/usr/bin/env bash

# Exports
export VISUAL="nvim"
export EDITOR="$VISUAL"
export MICRO_TRUECOLOR="1"
export GIT_EDITOR='nvim'
# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
export HISTFILE="$HOME/.zsh_history";
export SAVEHIST='5000';
setopt appendhistory;
# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Paths
export DOTS_DIR="$HOME/.dotfiles/"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

# add to PATH
declare -a ADDITIONNAL_PATHS=(
  "$HOME/.local/share/bob/nvim-bin"
)
# do the same without the join_by function
export PATH="$(echo "${ADDITIONNAL_PATHS[@]}" | tr ' ' ':'):$PATH"
