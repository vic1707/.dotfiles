#!/bin/sh

# Check for root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo."
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
## Uname ##
UNAME="$(uname -s)"
export UNAME
## SHELLS_TO_INSTALL ##
SHELLS_TO_INSTALL=''
export SHELLS_TO_INSTALL
## QUIET ##
QUIET=''
export QUIET

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
	git clone https://github.com/Homebrew/brew ~/homebrew
	mkdir -p ~/usr/local 
	export HOMEBREW_PREFIX="$HOME/usr/local"
	export PATH="$PATH:~/homebrew/bin:$HOMEBREW_PREFIX/bin"
fi

## Mise
curl https://mise.run | sh
eval "$HOME/.local/bin/mise activate zsh"

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
## GPG config
ln -fs "$DOTS_DIR/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"

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
mise install -y
brew install "$DOTS_DIR"/Brewfile
