#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

# bubblewrap: for ocaml/opam
# yasm: for ffmpeg
# libbz2-dev, libffi-dev, liblzma-dev, libsqlite3-dev, tk-dev, zlib1g-dev: for python
# byaac: for tmux
APT_PKGS="
adb
bubblewrap
imagemagick
jq
libbz2-dev
libffi-dev
liblzma-dev
libsqlite3-dev
luarocks
shellcheck
tk-dev
tree
yasm
zlib1g-dev
"

export APT_PKGS

###################################
# Install additionnal tools that  #
# requires particular setup       #
# Globals:                        #
#   SUDO_PREFIX                   #
#   QUIET                         #
# Returns:                        #
#   None                          #
###################################
additionnal_apt_installs() {
  APT_QUIET="$(if [ "$QUIET" = "-q" ]; then echo "-q -qq"; else echo ""; fi)"
  ## Install fury.io sources
  echo 'deb [trusted=yes] https://apt.fury.io/rsteube/ /' | sudo tee /etc/apt/sources.list.d/fury.list
  # shellcheck disable=SC2086
  $SUDO_PREFIX apt update $APT_QUIET
  # Install carapace-bin
  # shellcheck disable=SC2086
  $SUDO_PREFIX apt install -y carapace-bin $APT_QUIET
}
