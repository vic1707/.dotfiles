#!/bin/zsh

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Mise (former RTX-cli)
# shellcheck disable=SC1090 # sourced via external command
. <(mise activate zsh)

# Cargo-flamegraph
# bugged for now see https://github.com/flamegraph-rs/flamegraph/issues/263
# . <(flamegraph --completions zsh)

# Carapace-bin
# shellcheck disable=SC1090 # sourced via external command
. <(carapace _carapace zsh)

# Starship
# shellcheck disable=SC1090 # sourced via external command
. <(starship completions zsh)
