#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

# >>> xmake >>>
# shellcheck disable=SC1091 # loaded from external software
test -f "$HOME/.xmake/profile" && \. "$HOME/.xmake/profile" # load xmake profile
# <<< xmake <<<

# >>> Load cargo >>>
# shellcheck disable=SC1091 # loaded from external software
test -f "$HOME/.cargo/env" && \. "$HOME/.cargo/env"
# <<< Load cargo <<<
