#!/bin/sh

# Check for root privileges
if [ "$(id -u)" -eq 0 ]; then
    echo "This script must NOT be run as root."
    exit 1
fi

# check current dir
DOTS_DIR="$(cd "$(dirname "$0")" && pwd)"
export DOTS_DIR
# if DOTS_DIR is not `$HOME/.dotfiles`, warn and exit
if [ "$DOTS_DIR" != "$HOME/.dotfiles" ]; then
	echo "Error: DOTS_DIR is not $HOME/.dotfiles" >&2
	exit 1
fi

################################
##           GLOBALS          ##
################################
BASE_ZSH_PLUGINS_DIR="$DOTS_DIR/shell/.zsh-plugins"
UNAME="$(uname -s)"
SHELLS_TO_INSTALL=''
QUIET=''

################################
##  ARGUMENT PARSING OPTIONS  ##
################################
show_help() {
	echo "Usage: $0 [options]"
	echo "Options:"
	echo "  -h, --help        Show this help message"
	echo "  -q, --quiet       Quiet mode"
	echo "  --                End of options"
}

while :; do
	case "$1" in
		-h | --help | -\?)
			show_help
			exit 0
			;;
		-q | --quiet)
			QUIET='-q'
			shift
			;;
		--)
			shift
			break
			;;
		-?*)
			echo "invalid option: $1" 1>&2
			show_help
			exit 1
			;;
		*) break ;;
	esac
done

################################
##        REQUIREMENTS        ##
################################
## Homebrew (if MacOS) ##
if [ "$UNAME" = "Darwin" ]; then
	HOMEBREW_PATH="$HOME/.homebrew"
	git clone https://github.com/Homebrew/brew "$HOMEBREW_PATH"
	mkdir -p ~/usr/local 
	export HOMEBREW_PREFIX="$HOME/usr/local"
	export PATH="$PATH:"$HOMEBREW_PATH/bin":$HOMEBREW_PREFIX/bin"
    ## TODO: check for sudo
    sudo ln -fs  "$HOME/.homebrew" /opt/homebrew
    brew bundle
fi

## Mise
curl https://mise.run | sh
eval "$("$HOME/.local/bin/mise" activate bash)"

################################
##           INSTALL          ##
################################
## Config files ##
echo "-- Installing config files --"
## `.config` directory
mkdir -p "$HOME/.config"
## .config dir
ln -fs "$DOTS_DIR/.config"/* "$HOME/.config"
## Git config files
ln -fs "$DOTS_DIR/.gitconfig" "$HOME/.gitconfig"
ln -fs "$DOTS_DIR/.gitattributes" "$HOME/.gitattributes"
## Brew config files
ln -fs "$DOTS_DIR/Brewfile" "$HOME/Brewfile"

## Fonts ## ## TODO: c'est pété
# (install_fonts && echo "Fonts installed") || {
#   echo "Error: fonts could not be installed" >&2
#   exit 1;
# }

## Shells ##
echo "-- Installing bash environment --"
ln -fs "$DOTS_DIR/shell/.bashrc" "$HOME/.bashrc"
ln -fs "$DOTS_DIR/shell/.bash_profile" "$HOME/.bash_profile"

echo "-- Installing zsh environment --"
ln -fs "$DOTS_DIR/shell/.zshrc" "$HOME/.zshrc"
ln -fs "$DOTS_DIR/shell/.zshenv" "$HOME/.zshenv"

# plugins
ZSH_PLUGINS="
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-completions
zsh-users/zsh-autosuggestions
"
for plugin in $ZSH_PLUGINS; do
	if [ ! -d "$BASE_ZSH_PLUGINS_DIR/$plugin" ]; then
		# shellcheck disable=SC2086 # git doesn't like quotes around `$QUIET`
		git clone $QUIET "https://github.com/$plugin" "$BASE_ZSH_PLUGINS_DIR/${plugin#*/}"
	fi
done

## Install tools
mise trust "$DOTS_DIR/.config/mise/config.toml"
mise install -y

