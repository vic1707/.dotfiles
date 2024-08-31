#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

#####################################
# Install fonts in the fonts folder #
# Globals:                          #
#   HOME                            #
#   DOTS_DIR                        #
# Arguments:                        #
#   None                            #
# Returns:                          #
#   0 if install was successful     #
#####################################
install_fonts() {
	FONT_DIR="$([ "$(uname)" = 'Darwin' ] && echo "$HOME/Library/Fonts" || echo "$HOME/.local/share/fonts")"
	unzip "$DOTS_DIR"/fonts/*.zip -d "$FONT_DIR/"
}
