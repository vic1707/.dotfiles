#!/usr/bin/env sh

# SC1090: Can't follow non-constant source. Use a directive to specify location.
# SC1091: Not following
# shellcheck disable=SC1090,SC1091

##################################
##     Enable some softwares    ##
##################################
HOMEBREW_PATH="/opt/homebrew" # technically "$HOME/.homebrew"
test -f "$HOMEBREW_PATH/bin/brew" && eval "$("$HOMEBREW_PATH"/bin/brew shellenv)"

MISE_PATH="$HOME/.local/bin/mise"
eval "$("$MISE_PATH" activate "$SHELL_NAME")"
eval "$("$MISE_PATH" hook-env)"

CARGO_PATH="$HOME/.cargo"
test -f "$CARGO_PATH/env" && . "$CARGO_PATH/env"

eval "$(zoxide init "$SHELL_NAME")"

##################################
##   Enable shell completions   ##
##################################
## Check `carapace --list | sort` before enabling others

if [ "$SHELL_NAME" = "zsh" ]; then
	rg --generate complete-zsh > "$ZSH_COMPLETIONS_DIR/_rg"
elif [ "$SHELL_NAME" = "bash" ]; then
	rg --generate complete-bash > "$BASH_COMPLETIONS_DIR/rg.bash"
fi

eval "$(carapace _carapace)"
