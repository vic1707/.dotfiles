#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

# Exports
export EDITOR="nvim"
export GIT_EDITOR="$EDITOR"
export MICRO_TRUECOLOR="1"
export VISUAL="$EDITOR"
# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768'
export HISTFILESIZE="${HISTSIZE}"
export SAVEHIST='5000'
# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X'
