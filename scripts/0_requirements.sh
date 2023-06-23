#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

###################################
# Tries to find a supported       #
# package manager                 #
# Globals:                        #
#   None                          #
# Arguments:                      #
#   None                          #
# Returns:                        #
#   0 if a supported package      #
#     manager was found (echo it) #
#   1 if no supported package     #
#     manager was found           #
###################################
SUPPORTED_PM="brew apt apt-get"
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
# Arguments:                      #
#   $1: package manager           #
#   $2: command                   #
#   $3: enable allow flag (bool)  #
#   $4: enable quiet flag (bool)  #
# Returns:                        #
#   0 if a supported command & PM #
#     was passed                  #
#   1 if unsupported package      #
#     manager or command          #
#     was passed                  #
###################################
PM_commands() {
  if [ "$#" -ne 4 ]; then
    echo "Error: PM_commands expects 4 arguments" >&2
    exit 1
  fi
  if [ "$3" -ne 0 ]; then
    ALLOW='-y'
  else
    ALLOW=''
  fi
  case $1 in
      ##############
      ## Homebrew ##
      ##############
    brew)
      if [ "$4" -ne 0 ]; then
        QUIET='-q'
      else
        QUIET=''
      fi
      case $2 in
        update)
          echo "brew update $QUIET"
          return 0
          ;;
        install)
          echo "brew install $QUIET"
          return 0
          ;;
        upgrade)
          echo "brew upgrade $QUIET"
          return 0
          ;;
        install-reqs)
          # curl
          # cmake
          # pkg-config
          echo "brew install $QUIET curl cmake pkg-config"
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
      if [ "$4" -ne 0 ]; then
        QUIET='-qq'
      else
        QUIET=''
      fi
      case $2 in
        update)
          echo "$SUDO_PREFIX apt $ALLOW $QUIET update"
          return 0
          ;;
        install)
          echo "$SUDO_PREFIX apt $ALLOW $QUIET install"
          return 0
          ;;
        upgrade)
          echo "$SUDO_PREFIX apt $ALLOW $QUIET upgrade"
          return 0
          ;;
        install-reqs)
          # passwd: allows `chsh` command
          # curl
          # build-essential
          # cmake
          # libssl-dev
          # pkg-config
          echo "$SUDO_PREFIX apt $ALLOW $QUIET install passwd curl build-essential cmake libssl-dev pkg-config"
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
