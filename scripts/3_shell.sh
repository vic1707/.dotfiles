#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

########################################
# Install needed shell config files    #
# and plugins if needed                #
# Arguments:                           #
#   $1: shell to install (zsh|bash|nu) #
# Globals:                             #
#  None                                #
# Arguments:                           #
#   $1: shell to install (zsh|bash|nu) #
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
      nu)
        install_nu_env
        ;;
    esac
  done
}

######################
##       BASH       ##
######################
install_bash_env() {
  echo "-- Installing bash environment --"
  ln -fs "$DOTS_DIR/shell/bash/.bashrc" "$HOME/.bashrc"
}

######################
##        NU        ##
######################
install_nu_env() {
  echo "-- Installing nu environment --"
  if [ "$UNAME" = "Darwin" ]; then
    CONFIG_DIR="$HOME/Library/Application Support/nushell"
    mkdir -p "$HOME/Library/Application Support/nushell" # just in case
  else
    CONFIG_DIR="$HOME/.config/nushell"
    mkdir -p "$HOME/.config/nushell" # just in case
  fi
  # link config.nu && env.nu
  rm -rf "$CONFIG_DIR/config.nu" "$CONFIG_DIR/env.nu"
  ln -fs "$DOTS_DIR/shell/nu/config.nu" "$CONFIG_DIR/config.nu"
  ln -fs "$DOTS_DIR/shell/nu/env.nu" "$CONFIG_DIR/env.nu"
}

######################
##        ZSH       ##
######################
install_zsh_env() {
  echo "-- Installing zsh environment --"
  ln -fs "$DOTS_DIR/shell/zsh/.zshrc" "$HOME/.zshrc"

  #######################
  ##    zsh plugins    ##
  #######################
  for plugin in $ZSH_PLUGINS; do
    if [ ! -d "$BASE_ZSH_PLUGINS_DIR/$plugin" ]; then
      git clone -q "https://github.com/$plugin" "$BASE_ZSH_PLUGINS_DIR/${plugin#*/}"
    fi
  done
}
