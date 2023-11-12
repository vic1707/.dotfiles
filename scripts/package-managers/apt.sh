#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################
APT_PKGS="
adb
imagemagick
jq
luarocks
shellcheck
tmux
tree
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
