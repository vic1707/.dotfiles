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

# podman-desktop  - later
BREW_PKGS="
adobe-creative-cloud
android-platform-tools
anytype
arc
brave-browser
discord
gpg
imagemagick
jellyfin-media-player
jq
minecraft
notion
openssh
podman-desktop
slack
steam
tree
rsteube/tap/carapace
visual-studio-code
wezterm
"

export BREW_PKGS

###################################
# Install additionnal tools that  #
# requires particular setup       #
# Globals:                        #
#   SUDO_PREFIX                   #
#   QUIET                         #
# Returns:                        #
#   None                          #
###################################
additionnal_brew_installs() {
    # brew install --cask docker; ## if in BREW_PKGS it doesn't install GUI app nor compose
    true
}
