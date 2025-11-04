#!/usr/bin/env sh

export XDG_CONFIG_HOME="$HOME/.config"
export DOTS_DIR="$HOME/.dotfiles"
export BASE_ZSH_PLUGINS_DIR="$DOTS_DIR/shell/.zsh-plugins"

if [ -n "$ZSH_NAME" ]; then
	SHELL_NAME="zsh"
elif [ -n "$BASH" ]; then
	SHELL_NAME="bash"
fi
export SHELL_NAME

## Needs to be first to load everything right
# shellcheck source=shell/softwares.sh
. "$DOTS_DIR/shell/softwares.sh"

# shellcheck source=shell/aliases.sh
. "$DOTS_DIR/shell/aliases.sh"
# shellcheck source=shell/env.sh
. "$DOTS_DIR/shell/env.sh"
# shellcheck source=shell/functions.sh
. "$DOTS_DIR/shell/functions.sh"

LS_COLORS="$(vivid generate molokai)"
export LS_COLORS

if [ "$SHELL_NAME" = "zsh" ]; then
	# History
	autoload -U up-line-or-beginning-search down-line-or-beginning-search
	zle -N up-line-or-beginning-search
	zle -N down-line-or-beginning-search
	setopt appendhistory

	# shellcheck source=shell/keybindings.zsh
	. "$DOTS_DIR/shell/keybindings.zsh"

	for plugin in "$BASE_ZSH_PLUGINS_DIR"/*; do
		# shellcheck disable=SC1090
		test -d "$plugin" && \. "$plugin/${plugin##*/}.plugin.zsh"
	done
fi

eval "$(starship init "$SHELL_NAME")"
