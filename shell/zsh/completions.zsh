#!/bin/zsh

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# RTX
eval "$(rtx activate zsh)"

# Bob
eval "$(bob complete zsh)"

# Cargo-flamegraph
eval "$(flamegraph --completions zsh)"

# Carapace-bin
. <(carapace _carapace)

# Starship
eval "$(starship completions zsh)"
