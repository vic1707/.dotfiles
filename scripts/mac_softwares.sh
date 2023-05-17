#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install brew packages
BREW_PKGS="
ffmpeg
fzf
imagemagick
openssh
tmux
tree
rsteube/tap/carapace
"
# shellcheck disable=SC2046,SC2086
brew install $BREW_PKGS # brew doesn't like quotes around `$BREW_PKGS`
echo "Installing brew packages: $BREW_PKGS"
