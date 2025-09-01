#!/usr/bin/env sh

# SC1090: Can't follow non-constant source. Use a directive to specify location.
# SC1091: Not following
# shellcheck disable=SC1090,SC1091

##################################
##     Enable some softwares    ##
##################################
test -f "$HOMEBREW_PREFIX/bin/brew" && eval "$("$HOMEBREW_PREFIX"/bin/brew shellenv)"

eval "$(mise activate "$SHELL_NAME")"
eval "$(mise hook-env)"

##################################
##   Enable shell completions   ##
##################################
eval "$(carapace _carapace "$SHELL_NAME")"
eval "$(starship completions "$SHELL_NAME")"
# eval "$(rg --generate=complete-"$SHELL_NAME")" # ZSH bugged
