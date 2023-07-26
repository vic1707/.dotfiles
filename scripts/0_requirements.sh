#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

###################################
# Tries to find a supported       #
# package manager                 #
# Globals:                        #
#   SUPPORTED_PM                  #
# Arguments:                      #
#   None                          #
# Returns:                        #
#   0 if a supported package      #
#     manager was found (echo it) #
#   1 if no supported package     #
#     manager was found           #
###################################
find_package_manager() {
  for PM in $SUPPORTED_PM; do
    if command -v "$PM" >/dev/null 2>&1; then
      echo "$PM"
      return 0
    fi
  done
  echo "Error: No supported package manager found" >&2
  exit 1
}

###################################
# Prints the commands to update,  #
# install, upgrade or install     #
# requirements for a package      #
# manager                         #
# Globals:                        #
#   SUDO_PREFIX                   #
#   QUIET                         #
# Arguments:                      #
#   $1: package manager           #
#   $2: command                   #
# Returns:                        #
#   0 if a supported command & PM #
#     was passed                  #
#   1 if unsupported package      #
#     manager or command          #
#     was passed                  #
###################################
PM_commands() {
  case $1 in
      ##############
      ## Homebrew ##
      ##############
    brew)
      case $2 in
        update)
          echo "/opt/homebrew/bin/brew update $QUIET"
          return 0
          ;;
        install)
          echo "/opt/homebrew/bin/brew install $QUIET"
          return 0
          ;;
        upgrade)
          echo "/opt/homebrew/bin/brew upgrade $QUIET"
          return 0
          ;;
        install-reqs)
          # curl
          # cmake: Required to install `starship`
          # pkg-config
          echo "/opt/homebrew/bin/brew install $QUIET curl cmake pkg-config"
          return 0
          ;;
        install-additionnal)
          # shellcheck disable=SC2086 # brew doesn't like quotes
          echo "/opt/homebrew/bin/brew install $QUIET" $BREW_PKGS
          return 0
          ;;
        *)
          echo "Error: Unsupported command" >&2
          exit 1
          ;;
      esac
      ;;
      ###########
      ##  APT  ##
      ###########
    apt | apt-get)
      APT_QUIET="$(if [ "$QUIET" = "-q" ]; then echo "-q -qq"; else echo ""; fi)"
      case $2 in
        update)
          echo "$SUDO_PREFIX apt $APT_QUIET update"
          return 0
          ;;
        install)
          echo "$SUDO_PREFIX apt $APT_QUIET -y install"
          return 0
          ;;
        upgrade)
          echo "$SUDO_PREFIX apt $APT_QUIET -y upgrade"
          return 0
          ;;
        install-reqs)
          # passwd: allows `chsh` command
          # curl
          # build-essential
          # cmake
          # libssl-dev
          # pkg-config
          echo "$SUDO_PREFIX apt $APT_QUIET -y install passwd curl build-essential cmake libssl-dev pkg-config"
          return 0
          ;;
        install-additionnal)
          # shellcheck disable=SC2086 # apt doesn't like quotes
          echo "$SUDO_PREFIX apt $APT_QUIET -y install" $APT_PKGS
          return 0
          ;;
        *)
          echo "Error: Unsupported command" >&2
          exit 1
          ;;
      esac
      ;;
    *)
      echo "Error: Unsupported package manager" >&2
      exit 1
      ;;
  esac
}
