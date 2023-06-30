#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

# grep
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

# cat
if command -v bat > /dev/null; then
  alias cat='bat'
fi

# tail
alias t='tail -f'

# du
alias dud='du -d 1 -h'
alias duf='du -sh *'

# find
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# ls
if command -v exa > /dev/null; then
  alias ls='exa --icons'
fi
alias l='ls -lF'
alias la='ls -laF'
alias ll='ls -la'

# enable sccache for cargo
export RUSTC_WRAPPER=~/.cargo/bin/sccache

# vi
if command -v nvim > /dev/null; then
  alias vi='nvim'
  alias vim='nvim'
fi
