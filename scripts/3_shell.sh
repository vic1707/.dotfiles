#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

########################################
# Install needed shell config files    #
# and plugins if needed                #
# Arguments:                           #
#   $1: shell to install (zsh|bash)    #
# Globals:                             #
#  None                                #
# Arguments:                           #
#   $1: shell to install (zsh|bash)    #
# Returns:                             #
#   0 if install was successful        #
########################################
install_shells() {
	SHELLS_TO_INSTALL="$1"
	for choice in $SHELLS_TO_INSTALL; do
		case "$choice" in
			zsh)
				install_zsh_env
				;;
			bash)
				install_bash_env
				;;
		esac
	done
}

######################
##       BASH       ##
######################
install_bash_env() {
	echo "-- Installing bash environment --"
	ln -fs "$DOTS_DIR/shell/.bashrc" "$HOME/.bashrc"
	ln -fs "$DOTS_DIR/shell/.bash_profile" "$HOME/.bash_profile"
}

######################
##        ZSH       ##
######################
install_zsh_env() {
	echo "-- Installing zsh environment --"
	ln -fs "$DOTS_DIR/shell/.zshrc" "$HOME/.zshrc"
	ln -fs "$DOTS_DIR/shell/.zshenv" "$HOME/.zshenv"

	#######################
	##    zsh plugins    ##
	#######################
	for plugin in $ZSH_PLUGINS; do
		if [ ! -d "$BASE_ZSH_PLUGINS_DIR/$plugin" ]; then
			# shellcheck disable=SC2086 # git doesn't like quotes around `$QUIET`
			git clone $QUIET "https://github.com/$plugin" "$BASE_ZSH_PLUGINS_DIR/${plugin#*/}"
		fi
	done
}
