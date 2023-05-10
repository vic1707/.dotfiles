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
  cp -r "$HOME/.dotfiles/fonts/"* "$FONT_DIR"
  echo "Fonts installed to $FONT_DIR"
  return 0
}
