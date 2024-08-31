#!/bin/sh

### Uninstall all nvim lazy plugins

# are you sure ? (ask if $1 != -f|-y)
if [ "$1" != "-f" ] && [ "$1" != "-y" ]; then
	printf "Are you sure you want to uninstall all nvim lazy plugins ? [y/N] "
	read -r REPLY
	echo
	case $REPLY in
		[Yy]*) ;;
		*)
			echo "Aborting."
			exit 1
			;;
	esac
fi
echo "Uninstalling all nvim lazy plugins..."
rm -rf ~/.local/share/nvim/
rm -rf ~/.local/state/nvim/
rm -rf ~/.config/nvim/lazy-lock.json
