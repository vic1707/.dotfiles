#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

install_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
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
