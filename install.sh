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
## SHELLS_TO_INSTALL ##
SHELLS_TO_INSTALL=''
export SHELLS_TO_INSTALL
## SUDO PREFIX ##
SUDO_PREFIX="$(if [ "$(id -u)" -eq 0 ]; then echo ""; else echo "sudo"; fi)"
export SUDO_PREFIX
## QUIET ##
QUIET=''
export QUIET

################################
##  ARGUMENT PARSING OPTIONS  ##
################################
show_help() {
  # Please keep this in sync with the README
  JOINED_AVAILABLE_SHELLS="$(printf "%s" "$AVAILABLE_SHELLS" | tr ' ' '|')"
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  -h, --help        Show this help message"
  echo "  -q, --quiet       Quiet mode"
  echo "  -s, --shell       Install a shell ($JOINED_AVAILABLE_SHELLS)"
  echo "  --all-shells      Install all shells ($JOINED_AVAILABLE_SHELLS)"
  echo "  --                End of options"
}

while :; do
  case "$1" in
    -h|--help|-\?) show_help; exit 0 ;;
    -q|--quiet) QUIET='-q'; shift ;;
      # append shell to SHELLS_TO_INSTALL if it is in AVAILABLE_SHELLS
    -s|--shell)
      shift;
      if [ "$(echo " $AVAILABLE_SHELLS " | grep -c " $1 ")" -eq 1 ]; then
        SHELLS_TO_INSTALL="$SHELLS_TO_INSTALL $1"
      else
        echo "Error: $1 is not a valid shell" >&2
        exit 1;
      fi
      shift ;;
    --all-shells) SHELLS_TO_INSTALL="$AVAILABLE_SHELLS"; shift ;;
    --) shift; break ;;
    -?*) echo "invalid option: $1" 1>&2; show_help; exit 1 ;;
    *) break ;;
  esac
done

################################
##     ASK CONFIG OPTIONS     ##
################################
# ask shell if not already set
if [ -z "$SHELLS_TO_INSTALL" ]; then
  __ask_choice "Which shell do you want to install?" 0 "$AVAILABLE_SHELLS" SHELLS_TO_INSTALL
fi

################################
##        REQUIREMENTS        ##
################################
## Homebrew (if MacOS) ##
if [ "$UNAME" = "Darwin" ]; then
  # echo "Ensure XCODE license is accepted"
  # echo "Trying to accept the license $(date)";
  # while ! sudo xcodebuild -license accept 2>/dev/null; do
  #   sleep 2
  # done;
  # echo "License finally accepted $(date)";

  (install_brew && echo "Homebrew installed") || {
    echo "Error: Homebrew could not be installed" >&2
    exit 1;
  }
  # make requirements' bins available
  PATH="$PATH:/opt/homebrew/bin"
  export PATH
fi

################################
##       PACKAGE MANAGER      ##
################################
## Find package manager ##
PM="$(find_package_manager)"
export PM

## Update package manager ##
(PM_commands "$PM" update && echo "Package manager updated") || {
  echo "Error: package manager could not be updated" >&2
  exit 1;
}
## Upgrade package manager ##
(PM_commands "$PM" upgrade && echo "Package manager upgraded") || {
  echo "Error: package manager could not be upgraded" >&2
  exit 1;
}
## Requirements ##
(PM_commands "$PM" install-reqs && echo "Requirements installed") || {
  echo "Error: requirements could not be installed" >&2
  exit 1;
}
## Install SHELLS ##
(PM_commands "$PM" install "$AVAILABLE_SHELLS" && echo "Shells installed") || {
  echo "Error: shells could not be installed" >&2
  exit 1;
}
## additionnal packages ##
(PM_commands "$PM" install-additionnal && echo "Additionnal packages ($PM) installed") || {
  echo "Error: additionnal packages ($PM) could not be installed" >&2
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
(install_shells "$SHELLS_TO_INSTALL" && echo "Shell(s) installed") || {
  echo "Error: shell(s) could not be installed" >&2
  exit 1;
}
## Softwares ##
(install_rust && echo "Rust installed") || {
  echo "Failed to install rust" >&2
}
(install_xmake && echo "xmake installed") || {
  echo "Failed to install xmake" >&2
}
(install_cargo_pkgs && echo "Cargo packages installed") || {
  echo "Failed to install cargo packages" >&2
  echo "Is cargo installed?" >&2
}

# TODO: make cleaner
~/.cargo/bin/rtx install -y
