#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

install_brew() {
  if ! test -f "/opt/homebrew/bin/brew"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

BREW_PKGS="
ffmpeg
fzf
imagemagick
openssh
tmux
tree
rsteube/tap/carapace
android-platform-tools
"

export BREW_PKGS
