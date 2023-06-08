#!/bin/zsh

#############################################
# Updates:                                  #
#   - zsh plugins                           #
#   - rustup                                #
#   - cargo installs                        #
#   - xmake                                 #
#   - nvim                                  #
#   - node                                  #
#   - brew                                  #
# Globals:                                  #
#  HOME                                     #
# Arguments:                                #
#   None                                    #
# Returns:                                  #
#   0 if all updates are successful         #
#############################################
__update_all() {
  for plugin in "$BASE_ZSH_PLUGINS_DIR/"*; do
    if [ -d "$plugin" ]; then
      echo "Updating $plugin"
      cd "$plugin" || exit 1
      git pull
      cd - >/dev/null || exit 1
    fi
  done
  rustup update
  cargo install-update -a
  xmake update
  bob use latest
  rtx install node
  # if brew exists, update brew
  if __command_exists brew; then
    brew update
    brew upgrade
  fi
  return 0
}
