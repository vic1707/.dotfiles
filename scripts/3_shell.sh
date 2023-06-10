#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

#####################################
# Install needed shell config files #
# and plugins if needed             #
# Globals:                          #
#  None                             #
# Arguments:                        #
#   $1: shell to install (zsh|bash) #
# Returns:                          #
#   0 if install was successful     #
#####################################
install_shells() {
  SHELLS_TO_INSTALL=""
  __ask_choice "Which shell do you want to install?" 1 "$AVAILABLE_SHELLS" SHELLS_TO_INSTALL
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
  echo "Nothing to do for now"
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
