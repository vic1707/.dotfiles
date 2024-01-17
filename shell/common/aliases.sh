#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

# grep
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

# cat
test -f ~/.cargo/bin/bat && alias cat='bat'

# tail
alias t='tail -f'

# du
alias dud='du -d 1 -h'
alias duf='du -sh *'

# find
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# ls
test -f ~/.cargo/bin/exa && alias ls='exa --icons'
alias l='ls -lF'
alias la='ls -laF'
alias ll='ls -la'

# vi/vim
NVIM_BIN="$HOME/.local/share/mise/installs/neovim/latest/bin/nvim"
test -f "$NVIM_BIN" && alias vi="$NVIM_BIN"
test -f "$NVIM_BIN" && alias vim="$NVIM_BIN"

# docker
if command -v docker > /dev/null; then
  alias docker_nuke='docker system prune -a; docker volume prune -a'
fi

