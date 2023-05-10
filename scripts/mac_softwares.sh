#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install brew packages
PKGS="
  ffmpeg
  fzf
  imagemagick
  openssh
  tmux
  tree
  rsteube/tap/carapace
"
# shellcheck disable=SC2046,SC2086
brew install $PKGS # brew doesn't like quotes around `$PKGS`
echo "Installing brew packages: $PKGS"
