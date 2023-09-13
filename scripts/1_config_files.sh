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
  ## Aio-cli creds sample
  cp "$DOTS_DIR/.config/aio/creds.sample.yaml"  "$DOTS_DIR/.config/aio/creds.yaml"
  ## .config dir
  ln -fs "$DOTS_DIR/.config"/* "$HOME/.config"
  ## Git config files
  ln -fs "$DOTS_DIR/.gitconfig" "$HOME/.gitconfig"
  return 0
}
