#!/bin/zsh

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# RTX
. <(rtx activate zsh)

# Bob
. <(bob complete zsh)

# Cargo-flamegraph
# bugged for now see https://github.com/flamegraph-rs/flamegraph/issues/263
# . <(flamegraph --completions zsh)

# Carapace-bin
. <(carapace _carapace)

# Starship
. <(starship completions zsh)
