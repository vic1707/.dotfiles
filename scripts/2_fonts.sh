#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

#####################################
# Install fonts in the fonts folder #
# Globals:                          #
#  HOME                             #
# Arguments:                        #
#   None                            #
# Returns:                          #
#   0 if install was successful     #
#####################################
install_fonts() {
  FONT_DIR="$([ "$(uname)" = 'Darwin' ] && echo "$HOME/Library/Fonts" || echo "$HOME/.local/share/fonts")"
  ln -fs "$DOTS_DIR/fonts" "$FONT_DIR/custom_fonts"
  return 0
}
