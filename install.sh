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
install_shell_env 'zsh' # only install zsh for now
install_config_files
install_fonts
echo "Minimal config done"
