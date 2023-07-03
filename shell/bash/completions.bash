#!/bin/bash


# RTX
# shellcheck disable=SC1090 # sourced via external command
. <(rtx activate bash)

# Bob
# shellcheck disable=SC1090 # sourced via external command
. <(bob complete bash)

# Cargo-flamegraph
# shellcheck disable=SC1090 # sourced via external command
. <(flamegraph --completions bash)

# Carapace-bin
# shellcheck disable=SC1090 # sourced via external command
. <(carapace _carapace bash)

# Starship
# shellcheck disable=SC1090 # sourced via external command
. <(starship completions bash)
