#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

# yasm: for ffmpeg
# libbz2-dev, libffi-dev, liblzma-dev, libsqlite3-dev, tk-dev, zlib1g-dev: for python
APT_PKGS="
adb
imagemagick
libbz2-dev
libffi-dev
liblzma-dev
libsqlite3-dev
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
	# wezterm
	curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
	echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
	# shellcheck disable=SC2086
	$SUDO_PREFIX apt $APT_QUIET update
	# shellcheck disable=SC2086
	$SUDO_PREFIX apt install -y $APT_QUIET wezterm
}
