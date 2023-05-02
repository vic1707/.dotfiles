#!/bin/bash

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install brew packages
declare -a packages=(
  "ffmpeg"
  "fzf"
  "imagemagick"
  "openssh"
  "tmux"
  "tree"
)
brew install "${packages[@]}"
echo "Installed brew packages:" "${packages[@]}"
