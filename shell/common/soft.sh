#!/bin/sh

################################
# This script need to be POSIX #
################################

# >>> xmake >>>
test -f "$HOME/.xmake/profile" && \. "$HOME/.xmake/profile" # load xmake profile
# <<< xmake <<<

# >>> Load cargo >>>
test -f "$HOME/.cargo/env" && \. "$HOME/.cargo/env"
# <<< Load cargo <<<

# >>> Load RTX >>>
eval "$(rtx activate zsh)"
# <<< Load RTX <<<
