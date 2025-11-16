#!/usr/bin/env sh

ex() {
	! test -f "$1" && echo "'$1' is not a valid file" >&2 && return 1
	case "$1" in
		*.tar.bz2) tar xjf "$1" ;;
		*.tar.gz) tar xzf "$1" ;;
		*.tar.xz) tar xJf "$1" ;;
		*.bz2) bunzip2 "$1" ;;
		*.rar) unrar x "$1" ;;
		*.gz) gunzip "$1" ;;
		*.tar) tar xf "$1" ;;
		*.tbz2) tar xjf "$1" ;;
		*.tgz) tar xzf "$1" ;;
		*.zip) unzip "$1" ;;
		*.Z) uncompress "$1" ;;
		*.7z) 7z x "$1" ;;
		*)
			echo "'$1' cannot be extracted via ex()" >&2
			return 1
			;;
	esac
}

# Updates:
#   - mise tools
#   - zsh plugins
____update_env() {
	mise-updates check -g

	## Zsh plugins ##
	for plugin in "$BASE_ZSH_PLUGINS_DIR/"*; do
		if [ -d "$plugin" ]; then
			printf "[ZSH] Updating %-25s: " "$(echo "$plugin" | awk -F'/' '{print $NF}')"
			git -C "$plugin" pull
		fi
	done
}
