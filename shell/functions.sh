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
#   - rustup
#   - cargo
#   - xmake
#   - mise tools
____update_env() {
	## TODO: Package manager
	rustup update
	cargo install-update -a
	xmake update
	mise_tools_updates_checks

	## Zsh plugins ##
	for plugin in "$BASE_ZSH_PLUGINS_DIR/"*; do
		if [ -d "$plugin" ]; then
			printf "[ZSH] Updating %-25s: " "$(echo "$plugin" | awk -F'/' '{print $NF}')"
			git -C "$plugin" pull
		fi
	done
}

mise_tools_updates_checks() {
	mise --help > /dev/null 2>&1 || { echo "Mise not installed" && exit 1; }
	mise cache clean
	TOOLS="$(mise ls | cut -d ' ' -f 1 | uniq)"
	echo "$TOOLS" | while IFS= read -r TOOL; do
		CURRENT_VERSION="$(mise ls "$TOOL" | tail -n 1 | awk 'NR==1 {print $2}')"
		LATEST_VERSION="$(mise latest "$TOOL" 2> /dev/null || echo "err")"
		if [ "$LATEST_VERSION" = "err" ]; then
			printf "%-18s: Error while querying the last version." "$TOOL"
		elif [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
			printf "%-18s: Nothing to do." "$TOOL"
		else
			printf "%-18s: Can upgrade %10s ==> %-10s" "$TOOL" "$CURRENT_VERSION" "$LATEST_VERSION"
		fi
		echo ''
	done

	return 0
}

mise_upgrade_versions() {
	ALL="$1"
	mise --help > /dev/null 2>&1 || { echo "Mise not installed" && exit 1; }
	mise cache clean

	TOOLS=$(mise ls | cut -d ' ' -f 1 | uniq | tr '\n' ' ')
	TOOLS_TO_UPDATE=""

	setopt shwordsplit
	for TOOL in $TOOLS; do
		CURRENT_VERSION="$(mise ls "$TOOL" | tail -n 1 | awk 'NR==1 {print $2}')"
		LATEST_VERSION="$(mise latest "$TOOL" 2> /dev/null || echo "err")"
		if [ "$LATEST_VERSION" = "err" ]; then
			printf "%-18s: Error while querying the last version.\n" "$TOOL"
		elif [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
			printf "%-18s: Nothing to do.\n" "$TOOL"
		else
			if [ "$ALL" != "-y" ]; then
				printf "Upgrade %s from %s to %s? (y/n)" "$TOOL" "$CURRENT_VERSION" "$LATEST_VERSION"
				read -r REPLY
				if [ "$REPLY" = "y" ]; then
					TOOLS_TO_UPDATE="$TOOLS_TO_UPDATE $TOOL@$LATEST_VERSION"
					continue
				fi
				echo "Skipping $TOOL"
			else
				TOOLS_TO_UPDATE="$TOOLS_TO_UPDATE $TOOL@$LATEST_VERSION"
				printf "%-18s: Update from %s to %s.\n" "$TOOL" "$CURRENT_VERSION" "$LATEST_VERSION"
			fi
		fi
	done
	# shellcheck disable=SC2086
	[ -n "$TOOLS_TO_UPDATE" ] && mise use -g --pin $TOOLS_TO_UPDATE
	return 0
}
