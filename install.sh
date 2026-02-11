#!/bin/sh

# Check for root privileges
if [ "$(id -u)" -eq 0 ]; then
	echo "This script must NOT be run as root." >&2
	exit 1
fi

get() {
	url="$1"
	if hash curl; then
		curl $QUIET -fsSL "$url"
	elif hash wget; then
		wget $QUIET -O- "$url"
	else
		echo "Error: need curl or wget to download $url" >&2
		exit 1
	fi
}

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
QUIET=''
MISE_QUIET='false'

################################
##  ARGUMENT PARSING OPTIONS  ##
################################
show_help() {
	echo "Usage: $0 [options]"
	echo "Options:"
	echo "  -h, --help		Show this help message"
	echo "  -q, --quiet		Quiet mode"
	echo "  --				End of options"
}

while :; do
	case "$1" in
		-h | --help | -\?)
			show_help
			exit 0
			;;
		-q | --quiet)
			QUIET='-q'
			MISE_QUIET='true'
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
if [ "$(uname -s)" = "Darwin" ]; then
	if ! sudo -n true 2> /dev/null; then
		echo "Error: Brew requires 'sudo' capabilities." >&2
		exit 1
	fi

	export HOMEBREW_PATH="$HOME/.homebrew"
	git clone https://github.com/Homebrew/brew "$HOMEBREW_PATH"
	mkdir -p ~/usr/local
	export HOMEBREW_PREFIX="$HOME/usr/local"
	export PATH="$PATH:$HOMEBREW_PATH/bin:$HOMEBREW_PREFIX/bin"
	## TODO: check for sudo
	sudo ln -fs "$HOMEBREW_PATH" /opt/homebrew
	brew bundle $QUIET
fi

## Mise
export MISE_QUIET
get https://mise.run | sh
eval "$("$HOME/.local/bin/mise" activate bash)"

## Rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- $QUIET -y --profile default --no-modify-path

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
## GPG
mkdir -p "$HOME/.gnupg"
ln -fs "$DOTS_DIR/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"

## Fonts ##
while read -r font_url; do
	# skip empty lines or comments
	{ [ -z "$font_url" ] || case $font_url in \#*) true ;; *) false ;; esac } && continue
	file_name=$(basename "$font_url")
	tmpfile="$DOTS_DIR/fonts/$file_name"
	get "$font_url" > "$tmpfile"

	# source ex function
	. "$DOTS_DIR/shell/functions.sh"
	case "$file_name" in
		*.zip | *.rar | *.tar | *.gz)
			(
				cd "$DOTS_DIR/fonts" || exit 1
				ex "$DOTS_DIR/fonts/$file_name"
				rm -f "$tmpfile"
			)
			;;
	esac
done < "$DOTS_DIR/fonts/.fonts.conf"
if [ "$(uname -s)" = "Darwin" ]; then
	# "$HOME/Library/Fonts" already exist
	# can't be deleted without sudo
	# and doesn't support lns...
	cp -r "$DOTS_DIR"/fonts/* "$HOME/Library/Fonts/"
else
	ln -fs "$DOTS_DIR/fonts" "$HOME/.local/share/fonts"
	fc-cache -fv
fi

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
olets/zsh-transient-prompt
"
for plugin in $ZSH_PLUGINS; do
	if [ ! -d "$BASE_ZSH_PLUGINS_DIR/$plugin" ]; then
		git clone $QUIET "https://github.com/$plugin" "$BASE_ZSH_PLUGINS_DIR/${plugin#*/}"
	fi
done

## Install tools
mise trust "$DOTS_DIR/.config/mise/config.toml"
mise install -y
