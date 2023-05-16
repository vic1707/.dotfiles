#!/bin/sh

SUPPORTED_PM="brew apt apt-get"
SUPPORTED_PM_OPS="update install upgrade install-reqs"

find_package_manager() {
  for PM in $SUPPORTED_PM; do
    if command -v $PM >/dev/null 2>&1; then
      echo $PM
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
          echo "sudo apt update"
          ;;
        install)
          echo "sudo apt install"
          ;;
        upgrade)
          echo "sudo apt upgrade"
          ;;
        install-reqs)
          echo "sudo apt install curl build-essential cmake libssl-dev pkg-config"
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

echo "PM: $(find_package_manager)"
echo "update: $(PM_commands $(find_package_manager) update)"
echo "install: $(PM_commands $(find_package_manager) install)"
echo "upgrade: $(PM_commands $(find_package_manager) upgrade)"
echo "reqs: $(PM_commands $(find_package_manager) reqs)"
