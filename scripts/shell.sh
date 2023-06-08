#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

AVAILABLE_SHELLS="zsh bash"

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
ZSH_PLUGINS="
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-autosuggestions
"

install_zsh_env() {
  echo "-- Installing zsh environment --"
  ln -fs "$DOTS_DIR/shell/zsh/.zshrc" "$HOME/.zshrc"

  #######################
  ##    zsh plugins    ##
  #######################
  for plugin in $ZSH_PLUGINS; do
    if [ ! -d "$DOTS_DIR/zsh-plugins/$plugin" ]; then
      git clone -q "https://github.com/$plugin" "$DOTS_DIR/zsh-plugins/${plugin#*/}"
    fi
  done
}
