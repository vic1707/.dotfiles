#!/bin/sh

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

PM_commands() {
  # $1: package manager => must be in $SUPPORTED_PM
  # $2: command => update | install | upgrade | reqs
  case $1 in
      ##############
      ## Homebrew ##
      ##############
    brew)
      case $2 in
        update)
          echo "brew update"
          ;;
        install)
          echo "brew install"
          ;;
        upgrade)
          echo "brew upgrade"
          ;;
        install-reqs)
          # curl
          # cmake
          # pkg-config
          echo "brew install curl cmake pkg-config"
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
      case $2 in
        update)
          echo "$SUDO_PREFIX apt update"
          ;;
        install)
          echo "$SUDO_PREFIX apt install"
          ;;
        upgrade)
          echo "$SUDO_PREFIX apt upgrade"
          ;;
        install-reqs)
          # passwd: allows `chsh` command
          # curl
          # build-essential
          # cmake
          # libssl-dev
          # pkg-config
          echo "$SUDO_PREFIX apt install passwd curl build-essential cmake libssl-dev pkg-config"
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
