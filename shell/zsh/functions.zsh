#!/bin/zsh

#############################################
# Updates:                                  #
#   - environment                           #
#   - zsh plugins                           #
# Globals:                                  #
#   BASE_ZSH_PLUGINS_DIR                    #
# Arguments:                                #
#   None                                    #
# Returns:                                  #
#   0 if all updates are successful         #
#############################################
__update_all() {
  ____update_env
  ## Zsh plugins ##
  for plugin in "$BASE_ZSH_PLUGINS_DIR/"*; do
    if [ -d "$plugin" ]; then
      echo "Updating ${plugin##*/}"
      git -C "$plugin" pull
    fi
  done
  return 0
}
