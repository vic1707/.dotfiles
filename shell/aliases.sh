#!/usr/bin/env sh

# grep
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

# cat
bat --version > /dev/null && alias cat='bat'

# tail
alias t='tail -f'

# du
alias dud='du -d 1 -h'
alias duf='du -sh *'

# find
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# ls
eza --version > /dev/null && alias ls='eza --icons'
alias l='ls -lF'
alias la='ls -laF'
alias ll='ls -la'

if nvim --version > /dev/null; then
	alias vi="nvim"
	alias vim="nvim"
fi
