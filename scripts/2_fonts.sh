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
    cp "$DOTS_DIR"/fonts/*.otf "$FONT_DIR/"
    return 0
}
