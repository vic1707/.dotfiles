#!/usr/bin/env sh

# SC1090: Can't follow non-constant source. Use a directive to specify location.
# SC1091: Not following
# shellcheck disable=SC1090,SC1091

##################################
##     Enable some softwares    ##
##################################
HOMEBREW_PATH="$HOME/.homebrew"
test -f "$HOMEBREW_PATH/bin/brew" && eval "$("$HOMEBREW_PATH"/bin/brew shellenv)"

MISE_PATH="$HOME/.local/bin/mise"
eval "$("$MISE_PATH" activate "$SHELL_NAME")"
eval "$("$MISE_PATH" hook-env)"

##################################
##   Enable shell completions   ##
##################################
eval "$(carapace _carapace "$SHELL_NAME")"
eval "$(starship completions "$SHELL_NAME")"
eval "$(zoxide init "$SHELL_NAME")"
# eval "$(rg --generate=complete-"$SHELL_NAME")" # ZSH bugged
