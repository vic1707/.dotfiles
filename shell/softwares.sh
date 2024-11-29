#!/usr/bin/env sh

# SC1090: Can't follow non-constant source. Use a directive to specify location.
# SC1091: Not following
# SC3001: In POSIX sh, process substitution is undefined.
# shellcheck disable=SC1090,SC1091

##################################
##     Enable some softwares    ##
##################################
test -f "$HOME/.cargo/env" && eval "$(cat "$HOME"/.cargo/env)"
test -f "$HOME/.xmake/profile" && eval "$(cat "$HOME"/.xmake/profile)"
test -f "/opt/homebrew/bin/brew" && eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(mise activate "$SHELL_NAME")"
eval "$(mise hook-env)"

# Ocaml
if [ "$SHELL_NAME" = "zsh" ]; then
	eval "$(cat "$HOME"/.opam/opam-init/init.zsh)" || echo "please run 'opam init' to configure your environment"
elif [ "$SHELL_NAME" = "bash" ]; then
	eval "$(cat "$HOME"/.opam/opam-init/init.sh)" || echo "please run 'opam init' to configure your environment"
fi

##################################
##   Enable shell completions   ##
##################################
eval "$(carapace _carapace "$SHELL_NAME")"
eval "$(starship completions "$SHELL_NAME")"
eval "$(just --completions "$SHELL_NAME")"
# ZSH - bugged for now see https://github.com/gopasspw/gopass/issues/2934
[ "$SHELL_NAME" != "zsh" ] && eval "$(gopass completion "$SHELL_NAME")"
[ "$SHELL_NAME" = "zsh" ] && eval "$(gopass completion zsh | sed '$d'); compdef _gopass gopass"
# ZSH - bugged for now see https://github.com/flamegraph-rs/flamegraph/issues/263
[ "$SHELL_NAME" != "zsh" ] && eval "$(flamegraph --completions "$SHELL_NAME")"
