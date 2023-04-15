#!/bin/bash

alias zshrc='${=EDITOR} ~/.zshrc'

# grep
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

# tail
alias t='tail -f'

# du
alias dud='du -d 1 -h'
alias duf='du -sh *'

# find
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# ls
alias ls='ls --color'
alias l='ls -lFh'
alias la='ls -lAFh'
alias ll='ls -lAh'

# enable sccache for cargo
alias cargo='RUSTC_WRAPPER=sccache cargo'
