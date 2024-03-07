#!/bin/sh

### Uninstall all tmux plugins

# are you sure ? (ask if $1 != -f|-y)
if [ "$1" != "-f" ] && [ "$1" != "-y" ]; then
    printf "Are you sure you want to uninstall all tmux plugins ? [y/N] "
    read -r
    echo
    case $REPLY in
        [Yy]*) ;;
        *)
            echo "Aborting."
            exit 1
            ;;
    esac
fi
echo "Uninstalling all tmux plugins..."
rm -rf ~/.tmux
rm -rf ~/.config/tmux/plugins
