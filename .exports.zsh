#!/usr/bin/env bash

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
export HISTFILE=~/.zsh_history;
setopt appendhistory;

# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

export EDITOR=nano;