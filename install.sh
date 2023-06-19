#!/bin/sh

################################
##      check current dir     ##
################################
DOTS_DIR="$(cd "$(dirname "$0")" && pwd)"
export DOTS_DIR
# if DOTS_DIR is not `$HOME/.dotfiles`, warn and exit
if [ "$DOTS_DIR" != "$HOME/.dotfiles" ]; then
  echo "Error: DOTS_DIR is not $HOME/.dotfiles" >&2
  exit 1;
fi

echo "Installing dotfiles"

################################
## sourcing install functions ##
################################
# shellcheck source=scripts/__index.sh
. "$DOTS_DIR/scripts/__index.sh"

################################
##           GLOBALS          ##
################################
## Uname ##
UNAME="$(uname -s)"
export UNAME
## SUDO PREFIX ##
SUDO_PREFIX="$(if [ "$(id -u)" -eq 0 ]; then echo ""; else echo "sudo"; fi)"
export SUDO_PREFIX

################################
##        REQUIREMENTS        ##
################################
## Homebrew (if MacOS) ##
if [ "$UNAME" = "Darwin" ]; then
  (install_brew && echo "Homebrew installed") || {
    echo "Error: Homebrew could not be installed" >&2
    exit 1;
  }
fi

## Find package manager ##
PM="$(find_package_manager)"
export PM

## Update package manager ##
($(PM_commands "$PM" update) && echo "Package manager updated") || {
  echo "Error: package manager could not be updated" >&2
  exit 1;
}
## Requirements ##
($(PM_commands "$PM" install-reqs) && echo "Requirements installed") || {
  echo "Error: requirements could not be installed" >&2
  exit 1;
}

################################
##           INSTALL          ##
################################
## Config files ##
(install_config_files && echo "Config files installed") || {
  echo "Error: $HOME/.config already exists and is not empty" >&2
  exit 1;
}
## Fonts ##
(install_fonts && echo "Fonts installed") || {
  echo "Error: fonts could not be installed" >&2
  exit 1;
}
## Shell ##
(install_shells && echo "Shell(s) installed") || {
  echo "Error: shell(s) could not be installed" >&2
  exit 1;
}
## Softwares ##
(install_softwares && echo "Softwares installed") || {
  echo "Error: softwares could not be installed" >&2
  exit 1;
}
