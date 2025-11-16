#!/usr/bin/env sh

# grep
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}'

# cat
bat --version > /dev/null 2>&1 && alias cat='bat'

# tail
alias t='tail -f'

# du
alias dud='du -d 1 -h'
alias duf='du -sh *'

# ls
eza --version > /dev/null 2>&1 && alias ls='eza --icons'
alias l='ls -lF'
alias la='ls -laF'
alias ll='ls -la'

if nvim --version > /dev/null 2>&1; then
	alias vi='nvim'
	alias vim='nvim'
fi

which z > /dev/null && alias cd='z'

alias mise-updates="$DOTS_DIR/shell/scripts/mise-updates"
