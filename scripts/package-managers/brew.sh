#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

install_brew() {
  if ! test -f "/opt/homebrew/bin/brew"; then
    # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Only possible because sudo permissions are already granted (cause Xcode license)
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | NONINTERACTIVE=1 bash
  fi
}

BREW_PKGS="
arc
android-platform-tools
brave-browser
discord
ffmpeg
fzf
imagemagick
iterm2
jellyfin-media-player
notion
openssh
podman-desktop
tmux
tree
rsteube/tap/carapace
visual-studio-code
"

export BREW_PKGS
