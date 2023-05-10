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
install_shell_env() {
  if [ "$1" = "zsh" ]; then
    install_zsh_env
  elif [ "$1" = "bash" ]; then
    install_bash_env
  else
    echo "Error: install_shell_env: unknown shell $1" >&2
    exit 1
  fi
  return 0
}

######################
##       BASH       ##
######################
install_bash_env() {
  ## placeholder
  true;
}

######################
##        ZSH       ##
######################
install_zsh_env() {
  ln -fs "$DOTS_DIR/shell/zsh/.zshrc" "$HOME/.zshrc"

  #######################
  ##    zsh plugins    ##
  #######################
  PLUGINS="
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-autosuggestions
  "
  for plugin in $PLUGINS; do
    if [ ! -d "$HOME/.dotfiles/zsh-plugins/$plugin" ]; then
      git clone -q "https://github.com/$plugin" "$HOME/.dotfiles/zsh-plugins/${plugin#*/}"
    fi
  done
}
