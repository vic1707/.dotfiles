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
