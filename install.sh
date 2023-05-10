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
## create ln for config files ##
################################
ln -fs "$DOTS_DIR/.gitconfig" "$HOME/.gitconfig"
ln -fs "$DOTS_DIR/shell/zsh/.zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.config"
if [ -n "$(ls -A "$HOME/.config")" ]; then
  echo "Error: $HOME/.config already exists and is not empty" >&2
  exit 1;
fi
ln -fs "$DOTS_DIR/.config"* "$HOME/.config"

echo "Minimal config done"

## fonts
FONT_DIR="$([ "$(uname)" = 'Darwin' ] && echo "$HOME/Library/Fonts" || echo "$HOME/.local/share/fonts")"
cp -r "$HOME/.dotfiles/fonts/"* "$FONT_DIR"
echo "Fonts installed"
