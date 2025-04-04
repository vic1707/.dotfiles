#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

###################################
# Installs various config files   #
# such as dotfiles and the        #
# `.config` directory             #
# Globals:                        #
#  HOME                           #
#  DOTS_DIR                       #
# Arguments:                      #
#   None                          #
# Returns:                        #
#   0 if install was successful   #
#   1 if .config already exists   #
#         and is not empty        #
###################################
install_config_files() {
	## `.config` directory
	mkdir -p "$HOME/.config"
	## .config dir
	ln -fs "$DOTS_DIR/.config"/* "$HOME/.config"
	## Git config files
	ln -fs "$DOTS_DIR/.gitconfig" "$HOME/.gitconfig"
	ln -fs "$DOTS_DIR/.gitattributes" "$HOME/.gitattributes"
	## GPG config
	ln -fs "$DOTS_DIR/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"
	return 0
}
